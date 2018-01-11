/*
 * Copyright (c) 1997 Regents of the University of California.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *	This product includes software developed by the Daedalus Research
 *	Group at the University of California Berkeley.
 * 4. Neither the name of the University nor of the Laboratory may be used
 *    to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * Contributed by the Daedalus Research Group, http://daedalus.cs.berkeley.edu
 *
 * $Id: ll.cc,v 1.16 1998/10/10 12:50:37 broch Exp $
 */

#ifndef lint
static const char rcsid[] =
    "@(#) $Header: /usr/cvs/ns/ns-src/cmu/ll.cc,v 1.16 1998/10/10 12:50:37 broch Exp $ (UCB)";
#endif

#include <delay.h>
// #include <object.h>
#include <packet.h>

#include <debug.h>
#include <list.h>
#include <arp.h>
#include <topography.h>
#include <trace.h>
#include <node.h>
#include <mac.h>
#include <ll.h>
#include <random.h>
#include <mac-802_11.h>
#include <cmu/cbrp/hdr_cbrp.h>

static class LLHeaderClass : public PacketHeaderClass {
public:
	LLHeaderClass()
		: PacketHeaderClass("PacketHeader/LL", sizeof(hdr_ll)) {}
} class_llhdr;

static class LLClass : public TclClass {
public:
	LLClass() : TclClass("LL") {}
	TclObject* create(int, const char*const*) {
		return (new LL);
	}
} class_ll;



LL::LL() : LinkDelay(), seqno_(0)
{
	mac_ = 0;
	ifq_ = 0;
	sendtarget_ = 0;
	recvtarget_ = 0;

	bind("off_ll_", &off_ll_);
	bind("off_mac_", &off_mac_);
	bind("off_CBRP_", &off_cbrp_);
	
	bind_time("mindelay_", &mindelay_);
}


void
LL::handle(Event *e)
{
	/* Handler must be non-zero for outgoing packets. */

	recv((Packet*) e, (Handler*) 0);
}

int
LL::command(int argc, const char*const* argv)
{
	Tcl& tcl = Tcl::instance();
	if (argc == 3) {
                if(strcmp(argv[1], "arptable") == 0) {
                        arptable_ = (ARPTable*) TclObject::lookup(argv[2]);
                        assert(arptable_);
                        return TCL_OK;
                }
		if (strcmp(argv[1], "mac") == 0) {
			mac_ = (Mac*) TclObject::lookup(argv[2]);
                        assert(mac_);
			return (TCL_OK);
		}
		if (strcmp(argv[1], "ifq") == 0) {
			ifq_ = (Queue*) TclObject::lookup(argv[2]);
                        assert(ifq_);
			return (TCL_OK);
		}
		if (strcmp(argv[1], "recvtarget") == 0) {
			recvtarget_ = (NsObject*) TclObject::lookup(argv[2]);
                        assert(recvtarget_);
			return (TCL_OK);
		}
		if (strcmp(argv[1], "sendtarget") == 0) {
			sendtarget_ = (NsObject*) TclObject::lookup(argv[2]);
                        assert(sendtarget_);
			return (TCL_OK);
		}
	}
	else if (argc == 2) {
#if !defined(MONARCH)
		if (strcmp(argv[1], "peerLL") == 0) {
			tcl.resultf("%s", peerLL_->name());
			return (TCL_OK);
		}
#endif
		if (strcmp(argv[1], "mac") == 0) {
			tcl.resultf("%s", mac_->name());
			return (TCL_OK);
		}
		if (strcmp(argv[1], "ifq") == 0) {
			tcl.resultf("%s", ifq_->name());
			return (TCL_OK);
		}
		if (strcmp(argv[1], "sendtarget") == 0) {
			tcl.resultf("%s", sendtarget_->name());
			return (TCL_OK);
		}
		if (strcmp(argv[1], "recvtarget") == 0) {
			tcl.resultf("%s", recvtarget_->name());
			return (TCL_OK);
		}
	}
	return LinkDelay::command(argc, argv);
}



void
LL::recv(Packet* p, Handler*)
{
	char *mh = (char*) HDR_MAC(p);

	/*
	 * Sanity Check
	 */
	assert(initialized());

	if(p->incoming) {
		p->incoming = 0;
		if(mac_->hdr_type(mh) == ETHERTYPE_ARP)
			arptable_->arpinput(p, this);
		else
			recvfrom(p);
	}
	else {
#if 0
		hdr_cmn *ch = HDR_CMN(p);
                /*
		 * Stamp the packet with the "optimal" number of hops.
		 */
		if(ch->num_forwards() == 0)
			God::instance()->sentPacket(p);
#endif
		sendto(p);
	}
}


void
LL::recvfrom(Packet* p)
{
	Scheduler& s = Scheduler::instance();

        /*
         * No errored packets should be be passed up by the MAC
         * Layer.
         */
        assert(HDR_CMN(p)->error() == 0);

	/*
         * Li Jinyang: modified to extract useful hw address from HELLO pkt
         * May 6, 1999
	 */
	int ha;
        
	if (HDR_IP(p)->dst_ == IP_BROADCAST && (!HDR_CBRP(p)->valid())) {
		//STORE4BYTE(HDR_MAC(p)->dh_sa,&ha);
		ha = ETHER_ADDR(HDR_MAC(p)->dh_sa);
		if (ha!=this->mac_->address()) {
			arptable_->insertAddr(HDR_IP(p)->src(),ha,this);
		}
         	                            
	}	
        

	if (HDR_CMN(p)->error() > 0) {
		drop(p);
	}
	else {
		s.schedule(recvtarget_, p,
			   mindelay_ / 2 + delay_ * Random::uniform());
	}
	return;
}



void
LL::sendto(Packet* p)
{	
	Scheduler& s = Scheduler::instance();
	char *mh = (char*)p->access(off_mac_);
	hdr_ll *llh = (hdr_ll*)p->access(off_ll_);
	hdr_ip *ip = HDR_IP(p);

	// Sanity Check
	assert((u_int32_t) ip->dst() > 0);

	llh->seqno() = ++seqno_;
	llh->lltype() = LL_DATA;

	mac_->hdr_src(mh, mac_->address());
	mac_->hdr_type(mh, ETHERTYPE_IP);

	if(arptable_->arpresolve(p, this) == 0) {
              s.schedule(sendtarget_, p,
			 mindelay_ / 2 + delay_ * Random::uniform());
	}
}


void LL::dump()
{
}

