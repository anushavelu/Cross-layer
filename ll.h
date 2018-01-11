/* -*- c++ -*-
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
 * @(#) $Header: /usr/cvs/ns/ns-src/cmu/ll.h,v 1.9 1998/04/30 02:38:04 broch Exp $ (UCB)
 */

#ifndef ns_ll_h
#define ns_ll_h

#include <delay.h>
#include <queue.h>

#include <cmu/arp.h>
#include <cmu/node.h>
#include <cmu/god.h>

enum LLFrameType {
	LL_DATA	  = 0x0001,
	LL_ACK    = 0x0010,
};

struct hdr_ll {
	LLFrameType lltype_;	// link-layer frame type
	int seqno_;		// sequence number
	int ack_;		// acknowledgement number

	inline LLFrameType& lltype() { return lltype_; }
	inline int& seqno() { return seqno_; }
	inline int& ack() { return ack_; }
};


class LL : public LinkDelay {
public:
	LL();
	virtual void	recv(Packet* p, Handler* h);
	void 		handle(Event *e);
/*
        void insertARPAddr(int pa, int ha);
*/
	private:
	inline int initialized() {
		return (arptable_ && mac_ && recvtarget_ && sendtarget_);
	}

	friend ARPTable::arpinput(Packet *p, LL* ll);
	friend ARPTable::arprequest(nsaddr_t src, nsaddr_t dst, LL* ll);
#if 1
        friend ARPTable::insertAddr(int pa, int ha, LL *ll);
#endif
	int command(int argc, const char*const* argv);
	void dump(void);

	virtual void	sendto(Packet* p);
	virtual void	recvfrom(Packet* p);

	int seqno_;		// link-layer sequence number
	int off_ll_;		// offset of link-layer header
	int off_mac_;		// offset of MAC header
#if 1
	int off_cbrp_;
#endif
        NsObject* sendtarget_;	// where packet is passed down the stack
	NsObject* recvtarget_;	// where packet is passed up the stack

	ARPTable	*arptable_;
	Mac*		mac_;		// MAC object
        Queue*		ifq_;		/* interface queue */

	double		mindelay_;
};

#endif
