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
 *	This product includes software developed by the Computer Systems
 *	Engineering Group at Lawrence Berkeley Laboratory.
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
 * @(#) $Header: /usr/cvs/ns/ns-src/packet.h,v 1.29 1998/08/27 20:34:56 dmaltz Exp $ (LBL)
 */

#ifndef ns_packet_h
#define ns_packet_h

#include "config.h"
#include "scheduler.h"

#ifdef MONARCH
#include <assert.h>

class Packet;
class Channel;
class Mac;
class MobileNode;
class Modulation;
class Propagation;
#include <object.h>
#include <cmu/list.h>
#include <cmu/packet-stamp.h>

#define RT_PORT		255	/* port that all route msgs are sent to */

#define HDR_CMN(p)      ((struct hdr_cmn*)(p)->access(hdr_cmn::offset_))
#define HDR_ARP(p)      ((struct hdr_arp*)(p)->access(off_arp_))
#define HDR_MAC(p)      ((struct hdr_mac802_11*)(p)->access(off_mac_))
#define HDR_LL(p)       ((struct hdr_ll*)(p)->access(off_ll_))
#define HDR_IP(p)       ((struct hdr_ip*)(p)->access(hdr_ip::offset_))
#define HDR_RTP(p)      ((struct hdr_rtp*)(p)->access(off_rtp_))
#define HDR_TCP(p)      ((struct hdr_tcp*)(p)->access(off_tcp_))
#define HDR_TORA(p)     ((struct hdr_tora*)(p)->access(off_TORA_))
#define HDR_IMEP(p)	((struct hdr_imep*)(p)->access(off_IMEP_))
#define HDR_CBRP(p)     ((struct hdr_cbrp*)(p)->access(off_cbrp_))

#endif // MONARCH


#define DEBUG_PKT_ALLOC

#if defined(MONARCH) && defined(DEBUG_PKT_ALLOC)
#include <cmu/debug.h>
extern HashSet pkt_check;
#define NEW_PKT(p) pkt_check.insert((p));
#define FREE_PKT(p) {struct hb ** hbp = pkt_check.find((p)); \
	             if (0 == hbp) abort(); \
	             pkt_check.remove(hbp); }
#else
#define NEW_PKT(p)
#define FREE_PKT(p)
#endif

#define PT_TCP          0
#define PT_TELNET       1
#define PT_CBR          2
#define PT_AUDIO        3
#define PT_VIDEO        4
#define PT_ACK          5
#define PT_START        6
#define PT_STOP         7
#define PT_PRUNE        8
#define PT_GRAFT        9
#define PT_MESSAGE      10
#define PT_RTCP         11
#define PT_RTP          12
#define PT_RTPROTO_DV	13
#define PT_CtrMcast_Encap 14
#define PT_CtrMcast_Decap 15
#define PT_SRM		16
#ifdef MONARCH
#define PT_ARP		17
#define PT_MAC		18
#define PT_TORA		19
#define PT_DSR		20
#define PT_AODV         21
#define PT_IMEP		22
#define PT_CBRP         23
#define PT_NTYPE        24
#else
#define PT_NTYPE        17
#endif

/* PT_NAMES must be same numerical order as PT_* above */
#define PT_NAMES "tcp", "telnet", "cbr", "audio", "video", "ack", \
	"start", "stop", "prune", "graft", "message", "rtcp", "rtp", \
	"rtProtoDV", "CtrMcast_Encap", "CtrMcast_Decap", "SRM", \
	"ARP", "MAC", "TORA", "DSR", "AODV", "IMEP","CBRP"

extern char* packet_names[]; /* map PT_* to string name */

#define DATA_PACKET(type) ( (type) == PT_TCP || \
			    (type) == PT_TELNET || \
			    (type) == PT_CBR || \
			    (type) == PT_AUDIO || \
			    (type) == PT_VIDEO || \
			    (type) == PT_ACK \
			    )

#define OFFSET(type, field)	((int) &((type *)0)->field)

#ifdef MONARCH
typedef void (*FailureCallback)(Packet *,void *);
#endif

struct hdr_cmn {
	int	ptype_;		// packet type (see above)
	int	size_;		// simulated packet size
	int	uid_;		// unique id
	int	error_;		// error flag
	double	ts_;		// timestamp: for q-delay measurement
	int	iface_;		// receiving interface (label)

#ifdef MONARCH
        nsaddr_t prev_hop_;	// IP addr of forwarding hop
  /* The prev_hop_ variable is a bit of a hack.  While real overhead would
     required to carry the data in a real network, the only use of this
     variable is currently in AODV to track the active neighbor's list.
     Since a real implementation of AODV could be written that used
     the MAC addr to track the active neighbors (i.e., send route change
     notifications unicast to the neighbor's mac addr with the broadcast IP
     addr), there's no need to count any overhead against the AODV protocol
     and this field just simplifies AODV programming.  There's no 
     guarantee it even has a defined value when used with any other
     protocol. -dam 2/25/98 

     Alas, prev_hop_ is also used by TORA for disallowing routing loops.
     see tora/tora.cc (I'm not responsible for this....) -dam 8/17/98

     It's also now used to disambiguate incoming from outgoing packets.
     see imepAgent::recv().  I *am* responsible for this. -dam
     */

        nsaddr_t next_hop_;	// next hop for this packet
	int      addr_type_;    // type of next_hop_ addr
#define AF_NONE 0
#define AF_LINK 1
#define AF_INET 2

        // called if pkt can't obtain media or isn't ack'd. not called if
        // droped by a queue
        FailureCallback xmit_failure_; 
        void *xmit_failure_data_;

        /*
         * MONARCH wants to know if the MAC layer is passing this back because
         * it could not get the RTS through or because it did not receive
         * an ACK.
         */
        int     xmit_reason_;
#define XMIT_REASON_RTS 0x01
#define XMIT_REASON_ACK 0x02

        // filled in by GOD on first transmission, used for trace analysis
        int num_forwards_;	// how many times this pkt was forwarded
        int opt_num_forwards_;   // optimal #forwards

	inline nsaddr_t& next_hop() { return (next_hop_); }
	inline int& addr_type() { return (addr_type_); }
	inline int& num_forwards() { return (num_forwards_); }
	inline int& opt_num_forwards() { return (opt_num_forwards_); }

#endif MONARCH

	static int offset_;	// offset for this header
	inline int& offset() { return offset_; }

	/* per-field member functions */
	inline int& ptype() { return (ptype_); }
	inline int& size() { return (size_); }
	inline int& uid() { return (uid_); }
	inline int& error() { return error_; }
	inline double& timestamp() { return (ts_); }
	inline int& iface() { return (iface_); }
};


class PacketHeaderClass : public TclClass {
protected:
	PacketHeaderClass(const char* classname, int hdrsize);
	virtual int method(int argc, const char*const* argv);
	void field_offset(const char* fieldname, int offset);
	inline void offset(int* off) { offset_ = off; }
	int hdrlen_;		// # of bytes for this header
	int* offset_;		// offset for this header
public:
	virtual void bind();
	virtual void export_offsets();
        TclObject* create(int argc, const char*const* argv);
};

class Packet : public Event {
private:
	unsigned char* bits_;
	unsigned char* data_;	// variable size buffer for 'data'
	unsigned int datalen_;	// length of variable size buffer
protected:
	static Packet* free_;
public:
	Packet* next_;		// for queues and the free list
	static int hdrlen_;
	Packet() : bits_(0), datalen_(0), next_(0) { }
	unsigned char* const bits() { return (bits_); }
	Packet* copy() const;
        static Packet* alloc();
        static Packet* alloc(int);
	inline void allocdata(int);
        static void free(Packet*);
	inline unsigned char* access(int off) { if (off < 0) abort(); return (&bits_[off]); }
	inline unsigned char* accessdata() {return data_;}
#ifdef MONARCH
	static void dump_header(Packet *p, int offset, int length);

        // the pkt stamp carries all info about how/where the pkt
        // was sent needed for a receiver to determine if it correctly
        // receives the pkt
        PacketStamp	txinfo;  
	/*
	 * This flag is set by the MAC layer on an incoming packet
	 * and is cleared by the link layer.  It is an ugly hack, but
	 * there's really no other way because NS always calls
	 * the recv() function of an object.
	 */
	u_int8_t	incoming;
#endif
};

inline Packet* Packet::alloc()
{
	Packet* p = free_;
	if (p != 0)
		free_ = p->next_;
	else {
		p = new Packet;
		p->bits_ = new unsigned char[hdrlen_];
		if (p == 0 || p->bits_ == 0)
			abort();
	}
#ifdef MONARCH
	bzero(p->bits_, hdrlen_);
	p->incoming = 0;
	/* this can't be in the constructor b/c the constructor for
	   pkt_check gets called *after* a few packets are created, and
	   I couldn't figure out how to control the order in which
	   globals are constructed, so I'm gonna punt and call new packet
	   here.  there is a chance that if one the of the statically 
	   constructed pkts is freed, we'll blow up in FREE_PKT, since we
	   never saw the packet be created in the first place, but such a
	   free would be a bug itself (since the pkt isn't off the heap).
	   -dam 8/15/98 */
	NEW_PKT(p);
#endif
	return (p);
}

/* allocate a packet with an n byte data buffer */

inline Packet* Packet::alloc(int n)
{
        Packet* p = alloc();
	if (n > 0) 
	       p->allocdata(n);
	return (p);
}

/* allocate an n byte data buffer to an existing packet */

inline void Packet::allocdata(int n)
{
        datalen_ = n;
	data_ = new unsigned char[n];
	if (data_ == 0)
	        abort();

}

inline void Packet::free(Packet* p)
{
        FREE_PKT(p);

	p->next_ = free_;
	free_ = p;
	if (p->datalen_) {
	        delete p->data_;
		p->datalen_ = 0;
	}
}

inline Packet* Packet::copy() const
{
	Packet* p = alloc();
	memcpy(p->bits(), bits_, hdrlen_);
	if (datalen_) {
	        p->datalen_ = datalen_;
	        p->data_ = new unsigned char[datalen_];
		memcpy(p->data_, data_, datalen_);
	}
#ifdef MONARCH
	p->txinfo.init(&txinfo);
#endif
	return (p);
}

#ifdef MONARCH

inline void
Packet::dump_header(Packet *p, int offset, int length)
{
	assert(offset + length <= p->hdrlen_);
	struct hdr_cmn *ch = HDR_CMN(p);

	fprintf(stderr, "\nPacket ID: %d\n", ch->uid());

	for(int i = 0; i < length ; i+=16) {
		fprintf(stderr, "%02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
			p->bits_[offset + i],     p->bits_[offset + i + 1],
			p->bits_[offset + i + 2], p->bits_[offset + i + 3],
			p->bits_[offset + i + 4], p->bits_[offset + i + 5],
			p->bits_[offset + i + 6], p->bits_[offset + i + 7],
			p->bits_[offset + i + 8], p->bits_[offset + i + 9],
			p->bits_[offset + i + 10], p->bits_[offset + i + 11],
			p->bits_[offset + i + 12], p->bits_[offset + i + 13],
			p->bits_[offset + i + 14], p->bits_[offset + i + 15]);
	}
}

#endif // MONARCH

#endif
