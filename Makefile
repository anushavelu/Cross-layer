# Generated automatically from Makefile.in by configure.
#  Copyright (c) 1994, 1995, 1996
# 	The Regents of the University of California.  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that: (1) source code distributions
#  retain the above copyright notice and this paragraph in its entirety, (2)
#  distributions including binary code include the above copyright notice and
#  this paragraph in its entirety in the documentation or other materials
#  provided with the distribution, and (3) all advertising materials mentioning
#  features or use of this software display the following acknowledgement:
#  ``This product includes software developed by the University of California,
#  Lawrence Berkeley Laboratory and its contributors.'' Neither the name of
#  the University nor the names of its contributors may be used to endorse
#  or promote products derived from this software without specific prior
#  written permission.
#  THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#
# @(#) $Header: /usr/cvs/ns/ns-src/Makefile.in,v 1.34 1998/11/19 06:36:37 dmaltz Exp $ (LBL)
#
# Various configurable paths (remember to edit Makefile.in, not Makefile)
#

# Top level hierarchy
prefix	= /usr/local
# Pathname of directory to install the binary
BINDEST	= /usr/local/bin
# Pathname of directory to install the man page
MANDEST	= /usr/local/man

CC	= gcc
CPP	= c++
CCOPT	= -g

STATIC	= -static
DEFINE	= -DNO_TK  -DUSE_SHM -DHAVE_LIBTCLCL1_0B7 -DHAVE_TCLCL_H -DHAVE_LIBOTCL1_0A3 -DHAVE_OTCL_H -DHAVE_LIBTK8_0 -DHAVE_TK_H -DHAVE_LIBTCL8_0 -DHAVE_TCL_H  \
          -Dabort=_ABORT \
          -DMONARCH -DDSR_CACHE_STATS \
# -DDEBUG=4 \
# -DMEMDEBUG_SIMULATIONS  \

TCL2C	= ../tclcl-1.0b7/tcl2c++

INCLUDES = \
	-I. -I./cmu -I./cmu/dsr -I./cmu/dsdv -I./cmu/cbrp\
	 \
	-I../tclcl-1.0b7 -I../otcl-1.0a3 -I/ad-hoc/ad-hoc/ns-src/../tk8.0/generic -I../tcl8.0/generic 

LIB	= \
	-L../tclcl-1.0b7 -ltclcl -L../otcl-1.0a3 -lotcl -L/usr/lib -ltk8.0 -L/usr/lib -ltcl8.0  \
	-L/usr/X11R6/lib -lXext -lX11 \
	 -lnsl \
	-lm -ldl 

INSTALL	= /usr/bin/install -c
MKDEP	= makedepend
RANLIB	= ranlib


BLANK	= # make a blank space.  DO NOT add anything to this line
AR	= ar rc $(BLANK)
LINK	= $(CPP)
LDFLAGS	=
LDOUT	= -o $(BLANK)
PERL	= perl
RM	= rm -f
TCLSH	= ../tcl8.0/unix/tclsh

BFLAGS	= $(INCLUDES) $(DEFINE)
CFLAGS	= $(INCLUDES) $(DEFINE) $(CCOPT) -Wall

# Explicitly define compilation rules since SunOS 4's make doesn't like gcc.
# Also, gcc does not remove the .o before forking 'as', which can be a
# problem if you don't own the file but can write to the directory.
.SUFFIXES: .cc	# $(.SUFFIXES)

.cc.o:
	@rm -f $@
	$(CPP) -c $(CFLAGS) -o $@ $*.cc

.c.o:
	@rm -f $@
	$(CC) -c $(CFLAGS) -o $@ $*.c


GEN_DIR	= gen/
LIB_DIR	= lib/
NS	= ns
NSX	= nsx


# WIN32: uncomment the following line to include specific make for VC++
# !include <makefile.win>


OBJ_CC = \
	random.o rng.o ranvar.o misc.o timer-handler.o \
	scheduler.o object.o \
	packet.o ip.o route.o connector.o ttl.o \
	trace.o trace-ip.o \
	classifier.o classifier-addr.o classifier-flow.o classifier-hash.o \
	classifier-mcast.o classifier-mpath.o replicator.o \
	cbr.o traffictrace.o pareto.o expoo.o telnet.o tcplib-telnet.o \
	agent.o message.o udp.o session-rtp.o rtp.o rtcp.o ivs.o \
	tcp.o tcp-sink.o tcp-reno.o tcp-newreno.o \
	tcp-vegas.o tcp-rbp.o tcp-full.o \
	scoreboard.o tcp-sack1.o tcp-fack.o \
	tcp-asym.o tcp-asym-sink.o tcp-int.o chost.o nilist.o tcp-fs.o \
	integrator.o queue-monitor.o flowmon.o loss-monitor.o \
	queue.o drop-tail.o red.o \
	semantic-packetqueue.o semantic-red.o ack-recons.o \
	sfq.o fq.o drr.o cbq.o \
	hackloss.o errmodel.o \
	delay.o \
	dynalink.o rtProtoDV.o net-interface.o \
	ctrMcast.o prune.o srm.o \
	sessionhelper.o delaymodel.o srm-ssm.o \
	$(LIB_DIR)int.Vec.o $(LIB_DIR)int.RVec.o \
	$(LIB_DIR)dmalloc_support.o \
	net.o net-ip.o tap.o

###########################################################################
#
# Valid DSR caches: mobicache, linkcache
#
DSR_CACHE = mobicache

# All the files for each routing protocol we add should go on their
# own set of lines.  DO NOT add or change the common lines.
OBJ_CMU = \
	cmu/channel.o cmu/ll.o cmu/mac.o cmu/modulation.o   \
	cmu/arp.o cmu/node.o \
	cmu/net-if.o cmu/sharedmedia.o \
	cmu/antenna.o cmu/omni-antenna.o \
	cmu/propagation.o cmu/tworayground.o \
	cmu/dem.o cmu/topography.o \
	cmu/mac-802_3.o cmu/mac-802_11.o cmu/mac-timers.o \
	cmu/priqueue.o cmu/rtqueue.o cmu/rttable.o \
	cmu/god.o cmu/cmu-trace.o \
	\
	cmu/tora/tora.o cmu/tora/tora_api.o cmu/tora/tora_io.o \
	cmu/tora/tora_neighbor.o cmu/tora/tora_dest.o \
	cmu/tora/tora_logs.o \
	\
	cmu/imep/imep.o cmu/imep/imep_api.o cmu/imep/imep_rt.o \
	cmu/imep/imep_io.o cmu/imep/imep_util.o cmu/imep/imep_timers.o \
	cmu/imep/rxmit_queue.o cmu/imep/dest_queue.o \
	\
	cmu/dsr/path.o cmu/dsr/routecache.o cmu/dsr/requesttable.o \
	cmu/dsr/dsragent.o cmu/dsr/hdr_sr.o  \
	cmu/dsr/$(DSR_CACHE).o \
	\
	cmu/dsdv/rtable.o cmu/dsdv/dsdv.o \
	cmu/aodv/aodv.o cmu/aodv/aodv_logs.o \

OBJ_CBRP = \
	cmu/cbrp/cbrpagent.o cmu/cbrp/ntable.o cmu/cbrp/hdr_cbrp.o
######################################################################

OBJ_C = \
	inet.o

OBJ_COMPAT = $(OBJ_GETOPT) win32.o
#XXX compat/win32x.o compat/tkConsole.o

OBJ_NAM = \
	nam/animation.o \
	nam/nam-drop.o \
	nam/nam-edge.o \
	nam/nam-node.o \
	nam/nam-packet.o \
	nam/nam-queue.o \
	nam/nam-trace.o \
	nam/paint.o \
	nam/state.o \
	nam/transform.o \
	nam/netview.o \
	nam/netmodel.o

OBJ_GEN = $(GEN_DIR)version.o $(GEN_DIR)ns_tcl.o

SRC =	$(OBJ_C:.o=.c) $(OBJ_CC:.o=.cc) $(OBJ_NAM:.o=.cc) $(OBJ_CMU:.o=.cc) $(OBJ_CBRP:.o=.cc)\
	tclAppInit.cc tkAppInit.cc

OBJ =	$(OBJ_C) $(OBJ_CC) $(OBJ_GEN) $(OBJ_COMPAT) $(OBJ_CMU) $(OBJ_CBRP)
HDR =   agent.h config.h data-source.h integrator.h link.h node.h \
	object.h packet.h random.h scheduler.h scoreboard.h tcp.h trace.h \
	tcp-sink.h tcp-fack.h tcp-int.h chost.h drop-tail.h red.h \
	queue-monitor.h semantic-packetqueue.h ack-recons.h \
	cbr.h rtp.h cbr.h classifier.h connector.h ip.h \
	delay.h \
	snoop.h ll.h mac.h mac-multihop.h mac-csma.h mac-802_11.h \
	rtProtoDV.h ctrMcast.h prune.h ranvar.h delaymodel.h timers.h \
	srm-ssm.h mem-debug.h

CLEANFILES = ns nsx ns.dyn $(OBJ) $(OBJ_NAM) tclAppInit.o \
	$(GEN_DIR)* core core.ns core.nsx

$(NS): $(OBJ) tclAppInit.o
	$(LINK) $(STATIC) $(LDFLAGS) $(LDOUT)$@ \
		tclAppInit.o $(OBJ) $(LIB)

$(NSX): $(OBJ) tkAppInit.o $(OBJ_NAM)
	$(LINK) $(STATIC) $(LDFLAGS) $(LDOUT)$@ \
		tkAppInit.o $(OBJ) $(OBJ_NAM) $(LIB)

ns.dyn: $(OBJ) tclAppInit.o
	$(LINK) $(LDFLAGS) -o $@ \
		tclAppInit.o $(OBJ) $(LIB)

PURIFY	= purify -cache-dir=/tmp
ns-pure: $(OBJ) tclAppInit.o
	$(PURIFY) $(LINK) $(STATIC) $(LDFLAGS) -o $@ \
		tclAppInit.o $(OBJ) $(LIB)

NS_TCL_LIB = \
	tcl/lib/ns-compat.tcl \
	tcl/lib/ns-default.tcl \
	tcl/lib/ns-lib.tcl \
	tcl/lib/ns-link.tcl \
	tcl/lib/ns-node.tcl \
	tcl/lib/ns-packet.tcl \
	tcl/lib/ns-queue.tcl \
	tcl/lib/ns-source.tcl \
	tcl/lib/ns-nam.tcl \
	tcl/lib/ns-trace.tcl \
	tcl/lib/ns-agent.tcl \
	tcl/lib/ns-random.tcl \
	tcl/lib/ns-namsupp.tcl \
	tcl/rtp/session-rtp.tcl \
	tcl/rtglib/dynamics.tcl \
	tcl/rtglib/route-proto.tcl \
        tcl/interface/ns-iface.tcl \
        tcl/mcast/ns-mcast.tcl \
        tcl/mcast/McastProto.tcl \
        tcl/mcast/DM.tcl \
	tcl/mcast/detailedDM.tcl \
        tcl/mcast/dynamicDM.tcl \
        tcl/mcast/pimDM.tcl \
	tcl/mcast/srm.tcl \
	tcl/mcast/srm-adaptive.tcl \
	tcl/mcast/srm-ssm.tcl \
	tcl/mcast/timer.tcl \
	tcl/mcast/McastMonitor.tcl \
        tcl/ctr-mcast/CtrMcast.tcl \
        tcl/ctr-mcast/CtrMcastComp.tcl \
        tcl/ctr-mcast/CtrRPComp.tcl \
        tcl/pim/pim-init.tcl \
        tcl/pim/pim-messagers.tcl \
        tcl/pim/pim-mfc.tcl \
        tcl/pim/pim-mrt.tcl \
        tcl/pim/pim-recvr.tcl \
        tcl/pim/pim-sender.tcl \
        tcl/pim/pim-vifs.tcl \
	tcl/session/session.tcl \
	tcl/lib/ns-route.tcl

$(GEN_DIR)ns_tcl.cc: $(NS_TCL_LIB)
	if [ ! -x $(TCLSH) ] ; \
	then echo "$(TCLSH) not found..."; rm -rf $@ ; exit; fi ; \
	$(TCLSH) bin/tcl-expand.tcl tcl/lib/ns-lib.tcl | $(TCL2C) et_ns_lib > $@

$(GEN_DIR)version.c: VERSION
	$(RM) $@
	$(PERL) bin/printver.pl "char version_string[] = " < VERSION > $@
#	cat VERSION | sed 's/.*/char version_string[] = "&";/' > $@


install: force
	$(INSTALL) -m 555 -o bin -g bin ns $(DESTDIR)$(BINDEST)

install-man: force
	$(INSTALL) -m 444 -o bin -g bin ns.1 $(DESTDIR)$(MANDEST)/man1

clean:
	$(RM) $(CLEANFILES)

distclean:
	$(RM) $(CLEANFILES) Makefile config.cache config.log config.status \
	    gnuc.h os-proto.h

tags:	force
	ctags -wtd *.cc *.h ../Tcl/*.cc ../Tcl/*.h

TAGS:	force
	etags *.cc *.h ../Tcl/*.cc ../Tcl/*.h

depend: $(SRC)
	$(MKDEP) $(CFLAGS) -I/usr/include/g++ $(SRC)

srctar:
	@cwd=`pwd` ; dir=`basename $$cwd` ; \
	    name=ns-`cat VERSION | tr A-Z a-z` ; \
	    tar=ns-src-`cat VERSION`.tar.gz ; \
	    list="" ; \
	    for i in `cat FILES` ; do list="$$list $$name/$$i" ; done; \
	    echo \
	    "(rm -f $$tar; cd .. ; ln -s $$dir $$name)" ; \
	     (rm -f $$tar; cd .. ; ln -s $$dir $$name) ; \
	    echo \
	    "(cd .. ; tar cfh $$tar [lots of files])" ; \
	     (cd .. ; tar cfh - $$list) | gzip -c > $$tar ; \
	    echo \
	    "rm ../$$name; chmod 444 $$tar" ;  \
	     rm ../$$name; chmod 444 $$tar

force:

# DO NOT DELETE

inet.o: /usr/include/stdlib.h /usr/include/features.h
inet.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
inet.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
inet.o: /usr/include/sys/types.h /usr/include/bits/types.h
inet.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
inet.o: /usr/include/sys/select.h /usr/include/bits/select.h
inet.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
inet.o: /usr/include/alloca.h /usr/include/string.h /usr/include/ctype.h
inet.o: /usr/include/sys/param.h /usr/include/limits.h
inet.o: /usr/include/bits/posix1_lim.h /usr/include/bits/local_lim.h
inet.o: /usr/include/linux/limits.h /usr/include/bits/posix2_lim.h
inet.o: /usr/include/linux/param.h /usr/include/asm/param.h
inet.o: /usr/include/netdb.h /usr/include/rpc/netdb.h
inet.o: /usr/include/sys/socket.h /usr/include/bits/socket.h
inet.o: /usr/include/bits/sockaddr.h /usr/include/asm/socket.h
inet.o: /usr/include/asm/sockios.h config.h inet.h /usr/include/netinet/in.h
inet.o: /usr/include/stdint.h /usr/include/bits/wordsize.h
inet.o: /usr/include/bits/in.h /usr/include/bits/byteswap.h
inet.o: /usr/include/arpa/inet.h
random.o: /usr/include/sys/time.h /usr/include/features.h
random.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
random.o: /usr/include/time.h /usr/include/bits/types.h
random.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
random.o: /usr/include/sys/select.h /usr/include/bits/select.h
random.o: /usr/include/bits/sigset.h /usr/include/bits/time.h random.h
random.o: /usr/include/math.h /usr/include/bits/huge_val.h
random.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
random.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
random.o: config.h /usr/include/stdlib.h /usr/include/sys/types.h
random.o: /usr/include/endian.h /usr/include/bits/endian.h
random.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h rng.h
rng.o: /usr/include/sys/time.h /usr/include/features.h
rng.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h /usr/include/time.h
rng.o: /usr/include/bits/types.h
rng.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
rng.o: /usr/include/sys/select.h /usr/include/bits/select.h
rng.o: /usr/include/bits/sigset.h /usr/include/bits/time.h
rng.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
rng.o: /usr/include/bits/confname.h /usr/include/getopt.h
rng.o: /usr/include/stdio.h
rng.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
rng.o: /usr/include/libio.h /usr/include/_G_config.h
rng.o: /usr/include/bits/stdio_lim.h rng.h /usr/include/math.h
rng.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
rng.o: /usr/include/bits/mathcalls.h
rng.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
rng.o: /usr/include/stdlib.h /usr/include/sys/types.h /usr/include/endian.h
rng.o: /usr/include/bits/endian.h /usr/include/sys/sysmacros.h
rng.o: /usr/include/alloca.h
ranvar.o: ranvar.h random.h /usr/include/math.h /usr/include/features.h
ranvar.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
ranvar.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
ranvar.o: /usr/include/bits/mathcalls.h
ranvar.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
ranvar.o: config.h /usr/include/stdlib.h
ranvar.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
ranvar.o: /usr/include/sys/types.h /usr/include/bits/types.h
ranvar.o: /usr/include/time.h /usr/include/endian.h
ranvar.o: /usr/include/bits/endian.h /usr/include/sys/select.h
ranvar.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
ranvar.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h rng.h
misc.o: /usr/include/stdlib.h /usr/include/features.h
misc.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
misc.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
misc.o: /usr/include/sys/types.h /usr/include/bits/types.h
misc.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
misc.o: /usr/include/sys/select.h /usr/include/bits/select.h
misc.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
misc.o: /usr/include/alloca.h /usr/include/math.h
misc.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
misc.o: /usr/include/bits/mathcalls.h
misc.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
misc.o: /usr/include/sys/time.h /usr/include/bits/time.h /usr/include/ctype.h
misc.o: scheduler.h random.h config.h rng.h
timer-handler.o: /usr/include/stdlib.h /usr/include/features.h
timer-handler.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
timer-handler.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
timer-handler.o: /usr/include/sys/types.h /usr/include/bits/types.h
timer-handler.o: /usr/include/time.h /usr/include/endian.h
timer-handler.o: /usr/include/bits/endian.h /usr/include/sys/select.h
timer-handler.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
timer-handler.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
timer-handler.o: timer-handler.h scheduler.h
scheduler.o: /usr/include/stdlib.h /usr/include/features.h
scheduler.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
scheduler.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
scheduler.o: /usr/include/sys/types.h /usr/include/bits/types.h
scheduler.o: /usr/include/time.h /usr/include/endian.h
scheduler.o: /usr/include/bits/endian.h /usr/include/sys/select.h
scheduler.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
scheduler.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h config.h
scheduler.o: scheduler.h /usr/include/assert.h ./cmu/debug.h
scheduler.o: /usr/include/string.h heap.h /usr/include/sys/time.h
scheduler.o: /usr/include/bits/time.h
object.o: /usr/include/stdlib.h /usr/include/features.h
object.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
object.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
object.o: /usr/include/sys/types.h /usr/include/bits/types.h
object.o: /usr/include/time.h /usr/include/endian.h
object.o: /usr/include/bits/endian.h /usr/include/sys/select.h
object.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
object.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
object.o: /usr/include/ctype.h /usr/include/math.h
object.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
object.o: /usr/include/bits/mathcalls.h
object.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
object.o: packet.h config.h scheduler.h /usr/include/assert.h ./object.h
object.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
object.o: /usr/include/string.h
packet.o: flags.h config.h /usr/include/stdlib.h /usr/include/features.h
packet.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
packet.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
packet.o: /usr/include/sys/types.h /usr/include/bits/types.h
packet.o: /usr/include/time.h /usr/include/endian.h
packet.o: /usr/include/bits/endian.h /usr/include/sys/select.h
packet.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
packet.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
packet.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
packet.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
packet.o: /usr/include/string.h
ip.o: packet.h config.h /usr/include/stdlib.h /usr/include/features.h
ip.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
ip.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
ip.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
ip.o: /usr/include/endian.h /usr/include/bits/endian.h
ip.o: /usr/include/sys/select.h /usr/include/bits/select.h
ip.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
ip.o: /usr/include/alloca.h scheduler.h /usr/include/assert.h ./object.h
ip.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
ip.o: /usr/include/string.h ip.h
route.o: /usr/include/stdlib.h /usr/include/features.h
route.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
route.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
route.o: /usr/include/sys/types.h /usr/include/bits/types.h
route.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
route.o: /usr/include/sys/select.h /usr/include/bits/select.h
route.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
route.o: /usr/include/alloca.h /usr/include/assert.h
connector.o: packet.h config.h /usr/include/stdlib.h /usr/include/features.h
connector.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
connector.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
connector.o: /usr/include/sys/types.h /usr/include/bits/types.h
connector.o: /usr/include/time.h /usr/include/endian.h
connector.o: /usr/include/bits/endian.h /usr/include/sys/select.h
connector.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
connector.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h scheduler.h
connector.o: /usr/include/assert.h ./object.h ./cmu/list.h
connector.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
connector.o: /usr/include/string.h connector.h
ttl.o: packet.h config.h /usr/include/stdlib.h /usr/include/features.h
ttl.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
ttl.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
ttl.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
ttl.o: /usr/include/endian.h /usr/include/bits/endian.h
ttl.o: /usr/include/sys/select.h /usr/include/bits/select.h
ttl.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
ttl.o: /usr/include/alloca.h scheduler.h /usr/include/assert.h ./object.h
ttl.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
ttl.o: /usr/include/string.h ip.h connector.h
trace.o: /usr/include/stdio.h /usr/include/features.h
trace.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
trace.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
trace.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
trace.o: /usr/include/bits/types.h /usr/include/libio.h
trace.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
trace.o: /usr/include/stdlib.h /usr/include/sys/types.h /usr/include/time.h
trace.o: /usr/include/endian.h /usr/include/bits/endian.h
trace.o: /usr/include/sys/select.h /usr/include/bits/select.h
trace.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
trace.o: /usr/include/alloca.h packet.h config.h scheduler.h
trace.o: /usr/include/assert.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
trace.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h ip.h tcp.h
trace.o: agent.h connector.h timer-handler.h rtp.h flags.h trace.h
trace-ip.o: ip.h config.h /usr/include/stdlib.h /usr/include/features.h
trace-ip.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
trace-ip.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
trace-ip.o: /usr/include/sys/types.h /usr/include/bits/types.h
trace-ip.o: /usr/include/time.h /usr/include/endian.h
trace-ip.o: /usr/include/bits/endian.h /usr/include/sys/select.h
trace-ip.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
trace-ip.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
trace-ip.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
trace-ip.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
trace-ip.o: /usr/include/string.h trace.h connector.h ./cmu/mac.h ./cmu/ll.h
trace-ip.o: ./delay.h queue.h ./cmu/arp.h ./cmu/node.h ./cmu/net-if.h
trace-ip.o: ./cmu/channel.h ./cmu/topography.h ./cmu/god.h
trace-ip.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
trace-ip.o: ./cmu/marshall.h
classifier.o: /usr/include/stdlib.h /usr/include/features.h
classifier.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
classifier.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
classifier.o: /usr/include/sys/types.h /usr/include/bits/types.h
classifier.o: /usr/include/time.h /usr/include/endian.h
classifier.o: /usr/include/bits/endian.h /usr/include/sys/select.h
classifier.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
classifier.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h config.h
classifier.o: classifier.h ./object.h scheduler.h packet.h
classifier.o: /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
classifier.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h
classifier-addr.o: config.h /usr/include/stdlib.h /usr/include/features.h
classifier-addr.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
classifier-addr.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
classifier-addr.o: /usr/include/sys/types.h /usr/include/bits/types.h
classifier-addr.o: /usr/include/time.h /usr/include/endian.h
classifier-addr.o: /usr/include/bits/endian.h /usr/include/sys/select.h
classifier-addr.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
classifier-addr.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
classifier-addr.o: packet.h scheduler.h /usr/include/assert.h ./object.h
classifier-addr.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
classifier-addr.o: ./cmu/debug.h /usr/include/string.h ip.h classifier.h
classifier-flow.o: config.h /usr/include/stdlib.h /usr/include/features.h
classifier-flow.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
classifier-flow.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
classifier-flow.o: /usr/include/sys/types.h /usr/include/bits/types.h
classifier-flow.o: /usr/include/time.h /usr/include/endian.h
classifier-flow.o: /usr/include/bits/endian.h /usr/include/sys/select.h
classifier-flow.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
classifier-flow.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
classifier-flow.o: packet.h scheduler.h /usr/include/assert.h ./object.h
classifier-flow.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
classifier-flow.o: ./cmu/debug.h /usr/include/string.h ip.h classifier.h
classifier-hash.o: /usr/include/stdlib.h /usr/include/features.h
classifier-hash.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
classifier-hash.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
classifier-hash.o: /usr/include/sys/types.h /usr/include/bits/types.h
classifier-hash.o: /usr/include/time.h /usr/include/endian.h
classifier-hash.o: /usr/include/bits/endian.h /usr/include/sys/select.h
classifier-hash.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
classifier-hash.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
classifier-hash.o: config.h packet.h scheduler.h /usr/include/assert.h
classifier-hash.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h
classifier-hash.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h ip.h
classifier-hash.o: classifier.h
classifier-mcast.o: /usr/include/stdlib.h /usr/include/features.h
classifier-mcast.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
classifier-mcast.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
classifier-mcast.o: /usr/include/sys/types.h /usr/include/bits/types.h
classifier-mcast.o: /usr/include/time.h /usr/include/endian.h
classifier-mcast.o: /usr/include/bits/endian.h /usr/include/sys/select.h
classifier-mcast.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
classifier-mcast.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
classifier-mcast.o: config.h packet.h scheduler.h /usr/include/assert.h
classifier-mcast.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h
classifier-mcast.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h ip.h
classifier-mcast.o: classifier.h
classifier-mpath.o: classifier.h ./object.h scheduler.h
replicator.o: classifier.h ./object.h scheduler.h packet.h config.h
replicator.o: /usr/include/stdlib.h /usr/include/features.h
replicator.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
replicator.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
replicator.o: /usr/include/sys/types.h /usr/include/bits/types.h
replicator.o: /usr/include/time.h /usr/include/endian.h
replicator.o: /usr/include/bits/endian.h /usr/include/sys/select.h
replicator.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
replicator.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
replicator.o: /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
replicator.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h ip.h
cbr.o: cbr.h agent.h config.h /usr/include/stdlib.h /usr/include/features.h
cbr.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cbr.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cbr.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
cbr.o: /usr/include/endian.h /usr/include/bits/endian.h
cbr.o: /usr/include/sys/select.h /usr/include/bits/select.h
cbr.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
cbr.o: /usr/include/alloca.h packet.h scheduler.h /usr/include/assert.h
cbr.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cbr.o: ./cmu/debug.h /usr/include/string.h connector.h timer-handler.h rtp.h
cbr.o: random.h /usr/include/math.h /usr/include/bits/huge_val.h
cbr.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
cbr.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h rng.h
traffictrace.o: /usr/include/sys/types.h /usr/include/features.h
traffictrace.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
traffictrace.o: /usr/include/bits/types.h
traffictrace.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
traffictrace.o: /usr/include/time.h /usr/include/endian.h
traffictrace.o: /usr/include/bits/endian.h /usr/include/sys/select.h
traffictrace.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
traffictrace.o: /usr/include/sys/sysmacros.h /usr/include/sys/stat.h
traffictrace.o: /usr/include/bits/stat.h /usr/include/stdio.h
traffictrace.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
traffictrace.o: /usr/include/libio.h /usr/include/_G_config.h
traffictrace.o: /usr/include/bits/stdio_lim.h random.h /usr/include/math.h
traffictrace.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
traffictrace.o: /usr/include/bits/mathcalls.h
traffictrace.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
traffictrace.o: config.h /usr/include/stdlib.h /usr/include/alloca.h rng.h
traffictrace.o: ./object.h scheduler.h trafgen.h udp.h cbr.h agent.h packet.h
traffictrace.o: /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
traffictrace.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h
traffictrace.o: connector.h timer-handler.h
pareto.o: random.h /usr/include/math.h /usr/include/features.h
pareto.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
pareto.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
pareto.o: /usr/include/bits/mathcalls.h
pareto.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
pareto.o: config.h /usr/include/stdlib.h
pareto.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
pareto.o: /usr/include/sys/types.h /usr/include/bits/types.h
pareto.o: /usr/include/time.h /usr/include/endian.h
pareto.o: /usr/include/bits/endian.h /usr/include/sys/select.h
pareto.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
pareto.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h rng.h trafgen.h
pareto.o: ./object.h scheduler.h udp.h cbr.h agent.h packet.h
pareto.o: /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
pareto.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h connector.h
pareto.o: timer-handler.h
expoo.o: /usr/include/stdlib.h /usr/include/features.h
expoo.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
expoo.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
expoo.o: /usr/include/sys/types.h /usr/include/bits/types.h
expoo.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
expoo.o: /usr/include/sys/select.h /usr/include/bits/select.h
expoo.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
expoo.o: /usr/include/alloca.h random.h /usr/include/math.h
expoo.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
expoo.o: /usr/include/bits/mathcalls.h
expoo.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
expoo.o: config.h rng.h trafgen.h ./object.h scheduler.h udp.h cbr.h agent.h
expoo.o: packet.h /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
expoo.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h connector.h
expoo.o: timer-handler.h ranvar.h
telnet.o: random.h /usr/include/math.h /usr/include/features.h
telnet.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
telnet.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
telnet.o: /usr/include/bits/mathcalls.h
telnet.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
telnet.o: config.h /usr/include/stdlib.h
telnet.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
telnet.o: /usr/include/sys/types.h /usr/include/bits/types.h
telnet.o: /usr/include/time.h /usr/include/endian.h
telnet.o: /usr/include/bits/endian.h /usr/include/sys/select.h
telnet.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
telnet.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h rng.h tcp.h
telnet.o: agent.h packet.h scheduler.h /usr/include/assert.h ./object.h
telnet.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
telnet.o: /usr/include/string.h connector.h timer-handler.h telnet.h
tcplib-telnet.o: /usr/include/stdio.h /usr/include/features.h
tcplib-telnet.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcplib-telnet.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcplib-telnet.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
tcplib-telnet.o: /usr/include/bits/types.h /usr/include/libio.h
tcplib-telnet.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
tcplib-telnet.o: random.h /usr/include/math.h /usr/include/bits/huge_val.h
tcplib-telnet.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
tcplib-telnet.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
tcplib-telnet.o: config.h /usr/include/stdlib.h /usr/include/sys/types.h
tcplib-telnet.o: /usr/include/time.h /usr/include/endian.h
tcplib-telnet.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcplib-telnet.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcplib-telnet.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h rng.h
agent.o: /usr/include/stdlib.h /usr/include/features.h
agent.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
agent.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
agent.o: /usr/include/sys/types.h /usr/include/bits/types.h
agent.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
agent.o: /usr/include/sys/select.h /usr/include/bits/select.h
agent.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
agent.o: /usr/include/alloca.h /usr/include/string.h agent.h config.h
agent.o: packet.h scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
agent.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h connector.h
agent.o: timer-handler.h ip.h flags.h
message.o: agent.h config.h /usr/include/stdlib.h /usr/include/features.h
message.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
message.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
message.o: /usr/include/sys/types.h /usr/include/bits/types.h
message.o: /usr/include/time.h /usr/include/endian.h
message.o: /usr/include/bits/endian.h /usr/include/sys/select.h
message.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
message.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
message.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
message.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
message.o: /usr/include/string.h connector.h timer-handler.h random.h
message.o: /usr/include/math.h /usr/include/bits/huge_val.h
message.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
message.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
message.o: rng.h message.h
udp.o: udp.h cbr.h agent.h config.h /usr/include/stdlib.h
udp.o: /usr/include/features.h /usr/include/sys/cdefs.h
udp.o: /usr/include/gnu/stubs.h
udp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
udp.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
udp.o: /usr/include/endian.h /usr/include/bits/endian.h
udp.o: /usr/include/sys/select.h /usr/include/bits/select.h
udp.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
udp.o: /usr/include/alloca.h packet.h scheduler.h /usr/include/assert.h
udp.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
udp.o: ./cmu/debug.h /usr/include/string.h connector.h timer-handler.h
udp.o: trafgen.h rtp.h random.h /usr/include/math.h
udp.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
udp.o: /usr/include/bits/mathcalls.h
udp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h rng.h
session-rtp.o: /usr/include/stdlib.h /usr/include/features.h
session-rtp.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
session-rtp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
session-rtp.o: /usr/include/sys/types.h /usr/include/bits/types.h
session-rtp.o: /usr/include/time.h /usr/include/endian.h
session-rtp.o: /usr/include/bits/endian.h /usr/include/sys/select.h
session-rtp.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
session-rtp.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
session-rtp.o: config.h scheduler.h /usr/include/assert.h ./object.h
session-rtp.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
session-rtp.o: ./cmu/debug.h /usr/include/string.h ip.h rtp.h
rtp.o: /usr/include/stdlib.h /usr/include/features.h /usr/include/sys/cdefs.h
rtp.o: /usr/include/gnu/stubs.h
rtp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
rtp.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
rtp.o: /usr/include/endian.h /usr/include/bits/endian.h
rtp.o: /usr/include/sys/select.h /usr/include/bits/select.h
rtp.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
rtp.o: /usr/include/alloca.h /usr/include/string.h agent.h config.h packet.h
rtp.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
rtp.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h connector.h
rtp.o: timer-handler.h cbr.h random.h /usr/include/math.h
rtp.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
rtp.o: /usr/include/bits/mathcalls.h
rtp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h rng.h
rtp.o: rtp.h
rtcp.o: /usr/include/stdlib.h /usr/include/features.h
rtcp.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
rtcp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
rtcp.o: /usr/include/sys/types.h /usr/include/bits/types.h
rtcp.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
rtcp.o: /usr/include/sys/select.h /usr/include/bits/select.h
rtcp.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
rtcp.o: /usr/include/alloca.h /usr/include/string.h agent.h config.h packet.h
rtcp.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
rtcp.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h connector.h
rtcp.o: timer-handler.h random.h /usr/include/math.h
rtcp.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
rtcp.o: /usr/include/bits/mathcalls.h
rtcp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h rng.h
rtcp.o: rtp.h
ivs.o: /usr/include/stdlib.h /usr/include/features.h /usr/include/sys/cdefs.h
ivs.o: /usr/include/gnu/stubs.h
ivs.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
ivs.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
ivs.o: /usr/include/endian.h /usr/include/bits/endian.h
ivs.o: /usr/include/sys/select.h /usr/include/bits/select.h
ivs.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
ivs.o: /usr/include/alloca.h /usr/include/math.h /usr/include/bits/huge_val.h
ivs.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
ivs.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
ivs.o: packet.h config.h scheduler.h /usr/include/assert.h ./object.h
ivs.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
ivs.o: /usr/include/string.h cbr.h agent.h connector.h timer-handler.h
ivs.o: message.h trace.h
tcp.o: /usr/include/stdlib.h /usr/include/features.h /usr/include/sys/cdefs.h
tcp.o: /usr/include/gnu/stubs.h
tcp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
tcp.o: /usr/include/endian.h /usr/include/bits/endian.h
tcp.o: /usr/include/sys/select.h /usr/include/bits/select.h
tcp.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
tcp.o: /usr/include/alloca.h /usr/include/math.h /usr/include/bits/huge_val.h
tcp.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
tcp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
tcp.o: packet.h config.h scheduler.h /usr/include/assert.h ./object.h
tcp.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
tcp.o: /usr/include/string.h ip.h tcp.h agent.h connector.h timer-handler.h
tcp.o: flags.h random.h rng.h ./tcp-full.h
tcp-sink.o: tcp-sink.h /usr/include/math.h /usr/include/features.h
tcp-sink.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcp-sink.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
tcp-sink.o: /usr/include/bits/mathcalls.h
tcp-sink.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
tcp-sink.o: packet.h config.h /usr/include/stdlib.h
tcp-sink.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-sink.o: /usr/include/sys/types.h /usr/include/bits/types.h
tcp-sink.o: /usr/include/time.h /usr/include/endian.h
tcp-sink.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcp-sink.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcp-sink.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h scheduler.h
tcp-sink.o: /usr/include/assert.h ./object.h ./cmu/list.h
tcp-sink.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
tcp-sink.o: /usr/include/string.h ip.h tcp.h agent.h connector.h
tcp-sink.o: timer-handler.h flags.h ./tcp-full.h
tcp-reno.o: /usr/include/stdio.h /usr/include/features.h
tcp-reno.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcp-reno.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-reno.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
tcp-reno.o: /usr/include/bits/types.h /usr/include/libio.h
tcp-reno.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
tcp-reno.o: /usr/include/stdlib.h /usr/include/sys/types.h
tcp-reno.o: /usr/include/time.h /usr/include/endian.h
tcp-reno.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcp-reno.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcp-reno.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h ip.h config.h
tcp-reno.o: packet.h scheduler.h /usr/include/assert.h ./object.h
tcp-reno.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
tcp-reno.o: /usr/include/string.h tcp.h agent.h connector.h timer-handler.h
tcp-reno.o: flags.h
tcp-newreno.o: /usr/include/stdio.h /usr/include/features.h
tcp-newreno.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcp-newreno.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-newreno.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
tcp-newreno.o: /usr/include/bits/types.h /usr/include/libio.h
tcp-newreno.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
tcp-newreno.o: /usr/include/stdlib.h /usr/include/sys/types.h
tcp-newreno.o: /usr/include/time.h /usr/include/endian.h
tcp-newreno.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcp-newreno.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcp-newreno.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
tcp-newreno.o: config.h scheduler.h /usr/include/assert.h ./object.h
tcp-newreno.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
tcp-newreno.o: ./cmu/debug.h /usr/include/string.h ip.h tcp.h agent.h
tcp-newreno.o: connector.h timer-handler.h flags.h
tcp-vegas.o: /usr/include/stdio.h /usr/include/features.h
tcp-vegas.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcp-vegas.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-vegas.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
tcp-vegas.o: /usr/include/bits/types.h /usr/include/libio.h
tcp-vegas.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
tcp-vegas.o: /usr/include/stdlib.h /usr/include/sys/types.h
tcp-vegas.o: /usr/include/time.h /usr/include/endian.h
tcp-vegas.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcp-vegas.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcp-vegas.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h ip.h config.h
tcp-vegas.o: packet.h scheduler.h /usr/include/assert.h ./object.h
tcp-vegas.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
tcp-vegas.o: /usr/include/string.h tcp.h agent.h connector.h timer-handler.h
tcp-vegas.o: flags.h
tcp-rbp.o: /usr/include/stdio.h /usr/include/features.h
tcp-rbp.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcp-rbp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-rbp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
tcp-rbp.o: /usr/include/bits/types.h /usr/include/libio.h
tcp-rbp.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
tcp-rbp.o: /usr/include/stdlib.h /usr/include/sys/types.h /usr/include/time.h
tcp-rbp.o: /usr/include/endian.h /usr/include/bits/endian.h
tcp-rbp.o: /usr/include/sys/select.h /usr/include/bits/select.h
tcp-rbp.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
tcp-rbp.o: /usr/include/alloca.h ip.h config.h packet.h scheduler.h
tcp-rbp.o: /usr/include/assert.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
tcp-rbp.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h tcp.h agent.h
tcp-rbp.o: connector.h timer-handler.h flags.h
tcp-full.o: ip.h config.h /usr/include/stdlib.h /usr/include/features.h
tcp-full.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcp-full.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-full.o: /usr/include/sys/types.h /usr/include/bits/types.h
tcp-full.o: /usr/include/time.h /usr/include/endian.h
tcp-full.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcp-full.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcp-full.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
tcp-full.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
tcp-full.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
tcp-full.o: /usr/include/string.h ./tcp-full.h tcp.h agent.h connector.h
tcp-full.o: timer-handler.h flags.h random.h /usr/include/math.h
tcp-full.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
tcp-full.o: /usr/include/bits/mathcalls.h
tcp-full.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
tcp-full.o: rng.h template.h
scoreboard.o: /usr/include/stdlib.h /usr/include/features.h
scoreboard.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
scoreboard.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
scoreboard.o: /usr/include/sys/types.h /usr/include/bits/types.h
scoreboard.o: /usr/include/time.h /usr/include/endian.h
scoreboard.o: /usr/include/bits/endian.h /usr/include/sys/select.h
scoreboard.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
scoreboard.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
scoreboard.o: /usr/include/stdio.h
scoreboard.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
scoreboard.o: /usr/include/libio.h /usr/include/_G_config.h
scoreboard.o: /usr/include/bits/stdio_lim.h /usr/include/math.h
scoreboard.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
scoreboard.o: /usr/include/bits/mathcalls.h
scoreboard.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
scoreboard.o: packet.h config.h scheduler.h /usr/include/assert.h ./object.h
scoreboard.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
scoreboard.o: /usr/include/string.h scoreboard.h tcp.h agent.h connector.h
scoreboard.o: timer-handler.h
tcp-sack1.o: /usr/include/stdio.h /usr/include/features.h
tcp-sack1.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcp-sack1.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-sack1.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
tcp-sack1.o: /usr/include/bits/types.h /usr/include/libio.h
tcp-sack1.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
tcp-sack1.o: /usr/include/stdlib.h /usr/include/sys/types.h
tcp-sack1.o: /usr/include/time.h /usr/include/endian.h
tcp-sack1.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcp-sack1.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcp-sack1.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h ip.h config.h
tcp-sack1.o: packet.h scheduler.h /usr/include/assert.h ./object.h
tcp-sack1.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
tcp-sack1.o: /usr/include/string.h tcp.h agent.h connector.h timer-handler.h
tcp-sack1.o: flags.h scoreboard.h random.h /usr/include/math.h
tcp-sack1.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
tcp-sack1.o: /usr/include/bits/mathcalls.h
tcp-sack1.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
tcp-sack1.o: rng.h
tcp-fack.o: /usr/include/stdio.h /usr/include/features.h
tcp-fack.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcp-fack.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-fack.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
tcp-fack.o: /usr/include/bits/types.h /usr/include/libio.h
tcp-fack.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
tcp-fack.o: /usr/include/stdlib.h /usr/include/sys/types.h
tcp-fack.o: /usr/include/time.h /usr/include/endian.h
tcp-fack.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcp-fack.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcp-fack.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h ip.h config.h
tcp-fack.o: packet.h scheduler.h /usr/include/assert.h ./object.h
tcp-fack.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
tcp-fack.o: /usr/include/string.h tcp.h agent.h connector.h timer-handler.h
tcp-fack.o: flags.h scoreboard.h random.h /usr/include/math.h
tcp-fack.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
tcp-fack.o: /usr/include/bits/mathcalls.h
tcp-fack.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
tcp-fack.o: rng.h tcp-fack.h template.h
tcp-asym.o: tcp.h agent.h config.h /usr/include/stdlib.h
tcp-asym.o: /usr/include/features.h /usr/include/sys/cdefs.h
tcp-asym.o: /usr/include/gnu/stubs.h
tcp-asym.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-asym.o: /usr/include/sys/types.h /usr/include/bits/types.h
tcp-asym.o: /usr/include/time.h /usr/include/endian.h
tcp-asym.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcp-asym.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcp-asym.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
tcp-asym.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
tcp-asym.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
tcp-asym.o: /usr/include/string.h connector.h timer-handler.h ip.h flags.h
tcp-asym.o: random.h /usr/include/math.h /usr/include/bits/huge_val.h
tcp-asym.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
tcp-asym.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
tcp-asym.o: rng.h template.h
tcp-asym-sink.o: tcp-sink.h /usr/include/math.h /usr/include/features.h
tcp-asym-sink.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcp-asym-sink.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
tcp-asym-sink.o: /usr/include/bits/mathcalls.h
tcp-asym-sink.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
tcp-asym-sink.o: packet.h config.h /usr/include/stdlib.h
tcp-asym-sink.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-asym-sink.o: /usr/include/sys/types.h /usr/include/bits/types.h
tcp-asym-sink.o: /usr/include/time.h /usr/include/endian.h
tcp-asym-sink.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcp-asym-sink.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcp-asym-sink.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
tcp-asym-sink.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
tcp-asym-sink.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
tcp-asym-sink.o: /usr/include/string.h ip.h tcp.h agent.h connector.h
tcp-asym-sink.o: timer-handler.h flags.h template.h
tcp-int.o: /usr/include/stdio.h /usr/include/features.h
tcp-int.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tcp-int.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-int.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
tcp-int.o: /usr/include/bits/types.h /usr/include/libio.h
tcp-int.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
tcp-int.o: /usr/include/stdlib.h /usr/include/sys/types.h /usr/include/time.h
tcp-int.o: /usr/include/endian.h /usr/include/bits/endian.h
tcp-int.o: /usr/include/sys/select.h /usr/include/bits/select.h
tcp-int.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
tcp-int.o: /usr/include/alloca.h packet.h config.h scheduler.h
tcp-int.o: /usr/include/assert.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
tcp-int.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h ip.h tcp.h
tcp-int.o: agent.h connector.h timer-handler.h flags.h nilist.h tcp-int.h
tcp-int.o: chost.h random.h /usr/include/math.h /usr/include/bits/huge_val.h
tcp-int.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
tcp-int.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
tcp-int.o: rng.h
chost.o: nilist.h chost.h agent.h config.h /usr/include/stdlib.h
chost.o: /usr/include/features.h /usr/include/sys/cdefs.h
chost.o: /usr/include/gnu/stubs.h
chost.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
chost.o: /usr/include/sys/types.h /usr/include/bits/types.h
chost.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
chost.o: /usr/include/sys/select.h /usr/include/bits/select.h
chost.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
chost.o: /usr/include/alloca.h packet.h scheduler.h /usr/include/assert.h
chost.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
chost.o: ./cmu/debug.h /usr/include/string.h connector.h timer-handler.h
chost.o: tcp.h tcp-int.h random.h /usr/include/math.h
chost.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
chost.o: /usr/include/bits/mathcalls.h
chost.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
chost.o: rng.h
nilist.o: /usr/include/stdlib.h /usr/include/features.h
nilist.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
nilist.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
nilist.o: /usr/include/sys/types.h /usr/include/bits/types.h
nilist.o: /usr/include/time.h /usr/include/endian.h
nilist.o: /usr/include/bits/endian.h /usr/include/sys/select.h
nilist.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
nilist.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
nilist.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
nilist.o: /usr/include/bits/confname.h /usr/include/getopt.h nilist.h
tcp-fs.o: tcp.h agent.h config.h /usr/include/stdlib.h
tcp-fs.o: /usr/include/features.h /usr/include/sys/cdefs.h
tcp-fs.o: /usr/include/gnu/stubs.h
tcp-fs.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tcp-fs.o: /usr/include/sys/types.h /usr/include/bits/types.h
tcp-fs.o: /usr/include/time.h /usr/include/endian.h
tcp-fs.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tcp-fs.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tcp-fs.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
tcp-fs.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
tcp-fs.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
tcp-fs.o: /usr/include/string.h connector.h timer-handler.h ip.h flags.h
tcp-fs.o: random.h /usr/include/math.h /usr/include/bits/huge_val.h
tcp-fs.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
tcp-fs.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
tcp-fs.o: rng.h template.h tcp-fack.h scoreboard.h
integrator.o: /usr/include/stdlib.h /usr/include/features.h
integrator.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
integrator.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
integrator.o: /usr/include/sys/types.h /usr/include/bits/types.h
integrator.o: /usr/include/time.h /usr/include/endian.h
integrator.o: /usr/include/bits/endian.h /usr/include/sys/select.h
integrator.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
integrator.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h integrator.h
queue-monitor.o: queue-monitor.h integrator.h connector.h ./object.h
queue-monitor.o: scheduler.h packet.h config.h /usr/include/stdlib.h
queue-monitor.o: /usr/include/features.h /usr/include/sys/cdefs.h
queue-monitor.o: /usr/include/gnu/stubs.h
queue-monitor.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
queue-monitor.o: /usr/include/sys/types.h /usr/include/bits/types.h
queue-monitor.o: /usr/include/time.h /usr/include/endian.h
queue-monitor.o: /usr/include/bits/endian.h /usr/include/sys/select.h
queue-monitor.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
queue-monitor.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
queue-monitor.o: /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
queue-monitor.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h ip.h
flowmon.o: /usr/include/stdlib.h /usr/include/features.h
flowmon.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
flowmon.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
flowmon.o: /usr/include/sys/types.h /usr/include/bits/types.h
flowmon.o: /usr/include/time.h /usr/include/endian.h
flowmon.o: /usr/include/bits/endian.h /usr/include/sys/select.h
flowmon.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
flowmon.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h config.h
flowmon.o: queue-monitor.h integrator.h connector.h ./object.h scheduler.h
flowmon.o: packet.h /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
flowmon.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h classifier.h
flowmon.o: ip.h
loss-monitor.o: agent.h config.h /usr/include/stdlib.h
loss-monitor.o: /usr/include/features.h /usr/include/sys/cdefs.h
loss-monitor.o: /usr/include/gnu/stubs.h
loss-monitor.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
loss-monitor.o: /usr/include/sys/types.h /usr/include/bits/types.h
loss-monitor.o: /usr/include/time.h /usr/include/endian.h
loss-monitor.o: /usr/include/bits/endian.h /usr/include/sys/select.h
loss-monitor.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
loss-monitor.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
loss-monitor.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
loss-monitor.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
loss-monitor.o: /usr/include/string.h connector.h timer-handler.h ip.h rtp.h
queue.o: queue.h connector.h ./object.h scheduler.h packet.h config.h
queue.o: /usr/include/stdlib.h /usr/include/features.h
queue.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
queue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
queue.o: /usr/include/sys/types.h /usr/include/bits/types.h
queue.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
queue.o: /usr/include/sys/select.h /usr/include/bits/select.h
queue.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
queue.o: /usr/include/alloca.h /usr/include/assert.h ./cmu/list.h
queue.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
queue.o: /usr/include/string.h ip.h
drop-tail.o: drop-tail.h /usr/include/string.h /usr/include/features.h
drop-tail.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
drop-tail.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
drop-tail.o: queue.h connector.h ./object.h scheduler.h packet.h config.h
drop-tail.o: /usr/include/stdlib.h /usr/include/sys/types.h
drop-tail.o: /usr/include/bits/types.h /usr/include/time.h
drop-tail.o: /usr/include/endian.h /usr/include/bits/endian.h
drop-tail.o: /usr/include/sys/select.h /usr/include/bits/select.h
drop-tail.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
drop-tail.o: /usr/include/alloca.h /usr/include/assert.h ./cmu/list.h
drop-tail.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h ip.h
red.o: red.h /usr/include/math.h /usr/include/features.h
red.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
red.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
red.o: /usr/include/bits/mathcalls.h
red.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
red.o: /usr/include/string.h
red.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
red.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
red.o: /usr/include/endian.h /usr/include/bits/endian.h
red.o: /usr/include/sys/select.h /usr/include/bits/select.h
red.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h queue.h
red.o: connector.h ./object.h scheduler.h packet.h config.h
red.o: /usr/include/stdlib.h /usr/include/alloca.h /usr/include/assert.h
red.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h ip.h
red.o: random.h rng.h flags.h ./delay.h template.h
semantic-packetqueue.o: ip.h config.h /usr/include/stdlib.h
semantic-packetqueue.o: /usr/include/features.h /usr/include/sys/cdefs.h
semantic-packetqueue.o: /usr/include/gnu/stubs.h
semantic-packetqueue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
semantic-packetqueue.o: /usr/include/sys/types.h /usr/include/bits/types.h
semantic-packetqueue.o: /usr/include/time.h /usr/include/endian.h
semantic-packetqueue.o: /usr/include/bits/endian.h /usr/include/sys/select.h
semantic-packetqueue.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
semantic-packetqueue.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
semantic-packetqueue.o: packet.h scheduler.h /usr/include/assert.h ./object.h
semantic-packetqueue.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
semantic-packetqueue.o: ./cmu/debug.h /usr/include/string.h tcp.h agent.h
semantic-packetqueue.o: connector.h timer-handler.h template.h
semantic-packetqueue.o: semantic-packetqueue.h queue.h flags.h random.h
semantic-packetqueue.o: /usr/include/math.h /usr/include/bits/huge_val.h
semantic-packetqueue.o: /usr/include/bits/mathdef.h
semantic-packetqueue.o: /usr/include/bits/mathcalls.h
semantic-packetqueue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
semantic-packetqueue.o: rng.h ack-recons.h
semantic-red.o: red.h /usr/include/math.h /usr/include/features.h
semantic-red.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
semantic-red.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
semantic-red.o: /usr/include/bits/mathcalls.h
semantic-red.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
semantic-red.o: /usr/include/string.h
semantic-red.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
semantic-red.o: /usr/include/sys/types.h /usr/include/bits/types.h
semantic-red.o: /usr/include/time.h /usr/include/endian.h
semantic-red.o: /usr/include/bits/endian.h /usr/include/sys/select.h
semantic-red.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
semantic-red.o: /usr/include/sys/sysmacros.h queue.h connector.h ./object.h
semantic-red.o: scheduler.h packet.h config.h /usr/include/stdlib.h
semantic-red.o: /usr/include/alloca.h /usr/include/assert.h ./cmu/list.h
semantic-red.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h ip.h
semantic-red.o: random.h rng.h flags.h ./delay.h template.h
semantic-red.o: semantic-packetqueue.h tcp.h agent.h timer-handler.h
ack-recons.o: template.h config.h /usr/include/stdlib.h
ack-recons.o: /usr/include/features.h /usr/include/sys/cdefs.h
ack-recons.o: /usr/include/gnu/stubs.h
ack-recons.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
ack-recons.o: /usr/include/sys/types.h /usr/include/bits/types.h
ack-recons.o: /usr/include/time.h /usr/include/endian.h
ack-recons.o: /usr/include/bits/endian.h /usr/include/sys/select.h
ack-recons.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
ack-recons.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h ack-recons.h
ack-recons.o: semantic-packetqueue.h ./object.h scheduler.h connector.h
ack-recons.o: packet.h /usr/include/assert.h ./cmu/list.h
ack-recons.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
ack-recons.o: /usr/include/string.h queue.h ip.h flags.h random.h
ack-recons.o: /usr/include/math.h /usr/include/bits/huge_val.h
ack-recons.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
ack-recons.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
ack-recons.o: rng.h tcp.h agent.h timer-handler.h
sfq.o: /usr/include/stdlib.h /usr/include/features.h /usr/include/sys/cdefs.h
sfq.o: /usr/include/gnu/stubs.h
sfq.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
sfq.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
sfq.o: /usr/include/endian.h /usr/include/bits/endian.h
sfq.o: /usr/include/sys/select.h /usr/include/bits/select.h
sfq.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
sfq.o: /usr/include/alloca.h /usr/include/string.h queue.h connector.h
sfq.o: ./object.h scheduler.h packet.h config.h /usr/include/assert.h
sfq.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h ip.h
fq.o: /usr/include/stdlib.h /usr/include/features.h /usr/include/sys/cdefs.h
fq.o: /usr/include/gnu/stubs.h
fq.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
fq.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
fq.o: /usr/include/endian.h /usr/include/bits/endian.h
fq.o: /usr/include/sys/select.h /usr/include/bits/select.h
fq.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
fq.o: /usr/include/alloca.h /usr/include/string.h queue.h connector.h
fq.o: ./object.h scheduler.h packet.h config.h /usr/include/assert.h
fq.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h ip.h
drr.o: /usr/include/stdlib.h /usr/include/features.h /usr/include/sys/cdefs.h
drr.o: /usr/include/gnu/stubs.h
drr.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
drr.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
drr.o: /usr/include/endian.h /usr/include/bits/endian.h
drr.o: /usr/include/sys/select.h /usr/include/bits/select.h
drr.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
drr.o: /usr/include/alloca.h /usr/include/string.h queue.h connector.h
drr.o: ./object.h scheduler.h packet.h config.h /usr/include/assert.h
drr.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h ip.h
cbq.o: queue-monitor.h integrator.h connector.h ./object.h scheduler.h
cbq.o: packet.h config.h /usr/include/stdlib.h /usr/include/features.h
cbq.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cbq.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cbq.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
cbq.o: /usr/include/endian.h /usr/include/bits/endian.h
cbq.o: /usr/include/sys/select.h /usr/include/bits/select.h
cbq.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
cbq.o: /usr/include/alloca.h /usr/include/assert.h ./cmu/list.h
cbq.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cbq.o: /usr/include/string.h queue.h ip.h ./delay.h
hackloss.o: connector.h ./object.h scheduler.h packet.h config.h
hackloss.o: /usr/include/stdlib.h /usr/include/features.h
hackloss.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
hackloss.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
hackloss.o: /usr/include/sys/types.h /usr/include/bits/types.h
hackloss.o: /usr/include/time.h /usr/include/endian.h
hackloss.o: /usr/include/bits/endian.h /usr/include/sys/select.h
hackloss.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
hackloss.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
hackloss.o: /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
hackloss.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h queue.h ip.h
errmodel.o: ./delay.h /usr/include/assert.h /usr/include/features.h
errmodel.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h packet.h
errmodel.o: config.h /usr/include/stdlib.h
errmodel.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
errmodel.o: /usr/include/sys/types.h /usr/include/bits/types.h
errmodel.o: /usr/include/time.h /usr/include/endian.h
errmodel.o: /usr/include/bits/endian.h /usr/include/sys/select.h
errmodel.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
errmodel.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h scheduler.h
errmodel.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
errmodel.o: ./cmu/debug.h /usr/include/string.h queue.h connector.h ip.h
errmodel.o: ./cmu/arp.h ./cmu/ll.h ./cmu/arp.h ./cmu/node.h trace.h
errmodel.o: ./cmu/net-if.h ./cmu/channel.h ./cmu/topography.h ./cmu/god.h
errmodel.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
errmodel.o: ./cmu/mac.h ./cmu/ll.h ./cmu/marshall.h errmodel.h ranvar.h
errmodel.o: random.h /usr/include/math.h /usr/include/bits/huge_val.h
errmodel.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
errmodel.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
errmodel.o: rng.h srm-headers.h
delay.o: ./delay.h /usr/include/assert.h /usr/include/features.h
delay.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h packet.h config.h
delay.o: /usr/include/stdlib.h
delay.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
delay.o: /usr/include/sys/types.h /usr/include/bits/types.h
delay.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
delay.o: /usr/include/sys/select.h /usr/include/bits/select.h
delay.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
delay.o: /usr/include/alloca.h scheduler.h ./object.h ./cmu/list.h
delay.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
delay.o: /usr/include/string.h queue.h connector.h ip.h prune.h ctrMcast.h
dynalink.o: connector.h ./object.h scheduler.h
rtProtoDV.o: agent.h config.h /usr/include/stdlib.h /usr/include/features.h
rtProtoDV.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
rtProtoDV.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
rtProtoDV.o: /usr/include/sys/types.h /usr/include/bits/types.h
rtProtoDV.o: /usr/include/time.h /usr/include/endian.h
rtProtoDV.o: /usr/include/bits/endian.h /usr/include/sys/select.h
rtProtoDV.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
rtProtoDV.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
rtProtoDV.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
rtProtoDV.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
rtProtoDV.o: /usr/include/string.h connector.h timer-handler.h rtProtoDV.h
rtProtoDV.o: ip.h
net-interface.o: connector.h ./object.h scheduler.h packet.h config.h
net-interface.o: /usr/include/stdlib.h /usr/include/features.h
net-interface.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
net-interface.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
net-interface.o: /usr/include/sys/types.h /usr/include/bits/types.h
net-interface.o: /usr/include/time.h /usr/include/endian.h
net-interface.o: /usr/include/bits/endian.h /usr/include/sys/select.h
net-interface.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
net-interface.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
net-interface.o: /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
net-interface.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h trace.h
ctrMcast.o: agent.h config.h /usr/include/stdlib.h /usr/include/features.h
ctrMcast.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
ctrMcast.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
ctrMcast.o: /usr/include/sys/types.h /usr/include/bits/types.h
ctrMcast.o: /usr/include/time.h /usr/include/endian.h
ctrMcast.o: /usr/include/bits/endian.h /usr/include/sys/select.h
ctrMcast.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
ctrMcast.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
ctrMcast.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
ctrMcast.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
ctrMcast.o: /usr/include/string.h connector.h timer-handler.h ip.h ctrMcast.h
prune.o: agent.h config.h /usr/include/stdlib.h /usr/include/features.h
prune.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
prune.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
prune.o: /usr/include/sys/types.h /usr/include/bits/types.h
prune.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
prune.o: /usr/include/sys/select.h /usr/include/bits/select.h
prune.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
prune.o: /usr/include/alloca.h packet.h scheduler.h /usr/include/assert.h
prune.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
prune.o: ./cmu/debug.h /usr/include/string.h connector.h timer-handler.h
prune.o: random.h /usr/include/math.h /usr/include/bits/huge_val.h
prune.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
prune.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
prune.o: rng.h prune.h ip.h
srm.o: /usr/include/stdlib.h /usr/include/features.h /usr/include/sys/cdefs.h
srm.o: /usr/include/gnu/stubs.h
srm.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
srm.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
srm.o: /usr/include/endian.h /usr/include/bits/endian.h
srm.o: /usr/include/sys/select.h /usr/include/bits/select.h
srm.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
srm.o: /usr/include/alloca.h /usr/include/assert.h /usr/include/string.h
srm.o: /usr/include/stdio.h
srm.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
srm.o: /usr/include/libio.h /usr/include/_G_config.h
srm.o: /usr/include/bits/stdio_lim.h agent.h config.h packet.h scheduler.h
srm.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
srm.o: ./cmu/debug.h connector.h timer-handler.h ip.h srm.h
srm.o: /usr/include/math.h /usr/include/bits/huge_val.h
srm.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
srm.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h heap.h
srm.o: srm-state.h srm-headers.h trace.h
sessionhelper.o: ip.h config.h /usr/include/stdlib.h /usr/include/features.h
sessionhelper.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
sessionhelper.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
sessionhelper.o: /usr/include/sys/types.h /usr/include/bits/types.h
sessionhelper.o: /usr/include/time.h /usr/include/endian.h
sessionhelper.o: /usr/include/bits/endian.h /usr/include/sys/select.h
sessionhelper.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
sessionhelper.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
sessionhelper.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
sessionhelper.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
sessionhelper.o: /usr/include/string.h connector.h errmodel.h ranvar.h
sessionhelper.o: random.h /usr/include/math.h /usr/include/bits/huge_val.h
sessionhelper.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
sessionhelper.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
sessionhelper.o: rng.h
delaymodel.o: packet.h config.h /usr/include/stdlib.h /usr/include/features.h
delaymodel.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
delaymodel.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
delaymodel.o: /usr/include/sys/types.h /usr/include/bits/types.h
delaymodel.o: /usr/include/time.h /usr/include/endian.h
delaymodel.o: /usr/include/bits/endian.h /usr/include/sys/select.h
delaymodel.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
delaymodel.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h scheduler.h
delaymodel.o: /usr/include/assert.h ./object.h ./cmu/list.h
delaymodel.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
delaymodel.o: /usr/include/string.h delaymodel.h connector.h ranvar.h
delaymodel.o: random.h /usr/include/math.h /usr/include/bits/huge_val.h
delaymodel.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
delaymodel.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
delaymodel.o: rng.h
srm-ssm.o: /usr/include/stdlib.h /usr/include/features.h
srm-ssm.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
srm-ssm.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
srm-ssm.o: /usr/include/sys/types.h /usr/include/bits/types.h
srm-ssm.o: /usr/include/time.h /usr/include/endian.h
srm-ssm.o: /usr/include/bits/endian.h /usr/include/sys/select.h
srm-ssm.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
srm-ssm.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
srm-ssm.o: /usr/include/assert.h /usr/include/string.h /usr/include/stdio.h
srm-ssm.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
srm-ssm.o: /usr/include/libio.h /usr/include/_G_config.h
srm-ssm.o: /usr/include/bits/stdio_lim.h agent.h config.h packet.h
srm-ssm.o: scheduler.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
srm-ssm.o: ./cmu/antenna.h ./cmu/debug.h connector.h timer-handler.h ip.h
srm-ssm.o: srm.h /usr/include/math.h /usr/include/bits/huge_val.h
srm-ssm.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
srm-ssm.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
srm-ssm.o: heap.h srm-state.h srm-headers.h srm-ssm.h trace.h
lib/int.Vec.o: /usr/include/stdlib.h /usr/include/features.h
lib/int.Vec.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
lib/int.Vec.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
lib/int.Vec.o: /usr/include/sys/types.h /usr/include/bits/types.h
lib/int.Vec.o: /usr/include/time.h /usr/include/endian.h
lib/int.Vec.o: /usr/include/bits/endian.h /usr/include/sys/select.h
lib/int.Vec.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
lib/int.Vec.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
lib/int.Vec.o: lib/builtin.h /usr/include/stdio.h
lib/int.Vec.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
lib/int.Vec.o: /usr/include/libio.h /usr/include/_G_config.h
lib/int.Vec.o: /usr/include/bits/stdio_lim.h lib/int.Vec.h lib/builtin.h
lib/int.Vec.o: lib/int.defs.h
lib/int.RVec.o: lib/int.RVec.h lib/int.Vec.h lib/builtin.h lib/int.defs.h
lib/int.RVec.o: /usr/include/string.h /usr/include/features.h
lib/int.RVec.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
lib/int.RVec.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
net.o: /usr/include/stdlib.h /usr/include/features.h /usr/include/sys/cdefs.h
net.o: /usr/include/gnu/stubs.h
net.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
net.o: /usr/include/sys/types.h /usr/include/bits/types.h /usr/include/time.h
net.o: /usr/include/endian.h /usr/include/bits/endian.h
net.o: /usr/include/sys/select.h /usr/include/bits/select.h
net.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
net.o: /usr/include/alloca.h /usr/include/math.h /usr/include/bits/huge_val.h
net.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
net.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
net.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
net.o: /usr/include/bits/confname.h /usr/include/getopt.h
net.o: /usr/include/stdio.h
net.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
net.o: /usr/include/libio.h /usr/include/_G_config.h
net.o: /usr/include/bits/stdio_lim.h /usr/include/fcntl.h
net.o: /usr/include/bits/fcntl.h /usr/include/errno.h
net.o: /usr/include/bits/errno.h /usr/include/linux/errno.h
net.o: /usr/include/asm/errno.h /usr/include/string.h
net.o: /usr/include/sys/socket.h /usr/include/bits/socket.h
net.o: /usr/include/limits.h /usr/include/bits/posix1_lim.h
net.o: /usr/include/bits/local_lim.h /usr/include/linux/limits.h
net.o: /usr/include/bits/posix2_lim.h /usr/include/bits/sockaddr.h
net.o: /usr/include/asm/socket.h /usr/include/asm/sockios.h
net.o: /usr/include/sys/uio.h /usr/include/bits/uio.h net.h inet.h
net.o: /usr/include/netinet/in.h /usr/include/stdint.h
net.o: /usr/include/bits/wordsize.h /usr/include/bits/in.h
net.o: /usr/include/bits/byteswap.h /usr/include/arpa/inet.h config.h
net-ip.o: /usr/include/stdio.h /usr/include/features.h
net-ip.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
net-ip.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
net-ip.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
net-ip.o: /usr/include/bits/types.h /usr/include/libio.h
net-ip.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
net-ip.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
net-ip.o: /usr/include/bits/confname.h /usr/include/getopt.h
net-ip.o: /usr/include/time.h /usr/include/errno.h /usr/include/bits/errno.h
net-ip.o: /usr/include/linux/errno.h /usr/include/asm/errno.h
net-ip.o: /usr/include/string.h /usr/include/sys/param.h
net-ip.o: /usr/include/limits.h /usr/include/bits/posix1_lim.h
net-ip.o: /usr/include/bits/local_lim.h /usr/include/linux/limits.h
net-ip.o: /usr/include/bits/posix2_lim.h /usr/include/linux/param.h
net-ip.o: /usr/include/asm/param.h /usr/include/sys/types.h
net-ip.o: /usr/include/endian.h /usr/include/bits/endian.h
net-ip.o: /usr/include/sys/select.h /usr/include/bits/select.h
net-ip.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
net-ip.o: /usr/include/sys/socket.h /usr/include/bits/socket.h
net-ip.o: /usr/include/bits/sockaddr.h /usr/include/asm/socket.h
net-ip.o: /usr/include/asm/sockios.h /usr/include/sys/ioctl.h
net-ip.o: /usr/include/bits/ioctls.h /usr/include/asm/ioctls.h
net-ip.o: /usr/include/asm/ioctl.h /usr/include/bits/ioctl-types.h
net-ip.o: /usr/include/sys/ttydefaults.h config.h /usr/include/stdlib.h
net-ip.o: /usr/include/alloca.h net.h inet.h /usr/include/netinet/in.h
net-ip.o: /usr/include/stdint.h /usr/include/bits/wordsize.h
net-ip.o: /usr/include/bits/in.h /usr/include/bits/byteswap.h
net-ip.o: /usr/include/arpa/inet.h
tap.o: net.h inet.h /usr/include/sys/types.h /usr/include/features.h
tap.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tap.o: /usr/include/bits/types.h
tap.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tap.o: /usr/include/time.h /usr/include/endian.h /usr/include/bits/endian.h
tap.o: /usr/include/sys/select.h /usr/include/bits/select.h
tap.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
tap.o: /usr/include/netinet/in.h /usr/include/limits.h
tap.o: /usr/include/bits/posix1_lim.h /usr/include/bits/local_lim.h
tap.o: /usr/include/linux/limits.h /usr/include/bits/posix2_lim.h
tap.o: /usr/include/stdint.h /usr/include/bits/wordsize.h
tap.o: /usr/include/bits/socket.h /usr/include/bits/sockaddr.h
tap.o: /usr/include/asm/socket.h /usr/include/asm/sockios.h
tap.o: /usr/include/bits/in.h /usr/include/bits/byteswap.h
tap.o: /usr/include/arpa/inet.h config.h /usr/include/stdlib.h
tap.o: /usr/include/alloca.h packet.h scheduler.h /usr/include/assert.h
tap.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
tap.o: ./cmu/debug.h /usr/include/string.h agent.h connector.h
tap.o: timer-handler.h
nam/animation.o: nam/animation.h nam/bbox.h nam/state.h
nam/nam-drop.o: nam/netview.h nam/netmodel.h nam/nam-trace.h nam/transform.h
nam/nam-drop.o: /usr/include/tk.h /usr/include/tcl.h /usr/include/stdio.h
nam/nam-drop.o: /usr/include/features.h /usr/include/sys/cdefs.h
nam/nam-drop.o: /usr/include/gnu/stubs.h
nam/nam-drop.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
nam/nam-drop.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
nam/nam-drop.o: /usr/include/bits/types.h /usr/include/libio.h
nam/nam-drop.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
nam/nam-drop.o: /usr/include/X11/Xlib.h /usr/include/sys/types.h
nam/nam-drop.o: /usr/include/time.h /usr/include/endian.h
nam/nam-drop.o: /usr/include/bits/endian.h /usr/include/sys/select.h
nam/nam-drop.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
nam/nam-drop.o: /usr/include/sys/sysmacros.h /usr/include/X11/X.h
nam/nam-drop.o: /usr/include/X11/Xfuncproto.h /usr/include/X11/Xosdefs.h
nam/nam-drop.o: nam/nam-drop.h nam/animation.h nam/bbox.h nam/state.h
nam/nam-edge.o: /usr/include/math.h /usr/include/features.h
nam/nam-edge.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
nam/nam-edge.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
nam/nam-edge.o: /usr/include/bits/mathcalls.h
nam/nam-edge.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
nam/nam-edge.o: nam/nam-edge.h nam/animation.h nam/bbox.h nam/state.h
nam/nam-edge.o: nam/transform.h nam/nam-node.h nam/netview.h nam/netmodel.h
nam/nam-edge.o: nam/nam-trace.h /usr/include/tk.h /usr/include/tcl.h
nam/nam-edge.o: /usr/include/stdio.h
nam/nam-edge.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
nam/nam-edge.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
nam/nam-edge.o: /usr/include/bits/types.h /usr/include/libio.h
nam/nam-edge.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
nam/nam-edge.o: /usr/include/X11/Xlib.h /usr/include/sys/types.h
nam/nam-edge.o: /usr/include/time.h /usr/include/endian.h
nam/nam-edge.o: /usr/include/bits/endian.h /usr/include/sys/select.h
nam/nam-edge.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
nam/nam-edge.o: /usr/include/sys/sysmacros.h /usr/include/X11/X.h
nam/nam-edge.o: /usr/include/X11/Xfuncproto.h /usr/include/X11/Xosdefs.h
nam/nam-edge.o: nam/paint.h
nam/nam-node.o: /usr/include/stdlib.h /usr/include/features.h
nam/nam-node.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
nam/nam-node.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
nam/nam-node.o: /usr/include/sys/types.h /usr/include/bits/types.h
nam/nam-node.o: /usr/include/time.h /usr/include/endian.h
nam/nam-node.o: /usr/include/bits/endian.h /usr/include/sys/select.h
nam/nam-node.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
nam/nam-node.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
nam/nam-node.o: /usr/include/math.h /usr/include/bits/huge_val.h
nam/nam-node.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
nam/nam-node.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
nam/nam-node.o: nam/netview.h nam/netmodel.h nam/nam-trace.h nam/transform.h
nam/nam-node.o: /usr/include/tk.h /usr/include/tcl.h /usr/include/stdio.h
nam/nam-node.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
nam/nam-node.o: /usr/include/libio.h /usr/include/_G_config.h
nam/nam-node.o: /usr/include/bits/stdio_lim.h /usr/include/X11/Xlib.h
nam/nam-node.o: /usr/include/X11/X.h /usr/include/X11/Xfuncproto.h
nam/nam-node.o: /usr/include/X11/Xosdefs.h nam/nam-node.h nam/animation.h
nam/nam-node.o: nam/bbox.h nam/state.h nam/nam-edge.h nam/paint.h
nam/nam-packet.o: nam/transform.h nam/netview.h nam/netmodel.h
nam/nam-packet.o: nam/nam-trace.h /usr/include/tk.h /usr/include/tcl.h
nam/nam-packet.o: /usr/include/stdio.h /usr/include/features.h
nam/nam-packet.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
nam/nam-packet.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
nam/nam-packet.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
nam/nam-packet.o: /usr/include/bits/types.h /usr/include/libio.h
nam/nam-packet.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
nam/nam-packet.o: /usr/include/X11/Xlib.h /usr/include/sys/types.h
nam/nam-packet.o: /usr/include/time.h /usr/include/endian.h
nam/nam-packet.o: /usr/include/bits/endian.h /usr/include/sys/select.h
nam/nam-packet.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
nam/nam-packet.o: /usr/include/sys/sysmacros.h /usr/include/X11/X.h
nam/nam-packet.o: /usr/include/X11/Xfuncproto.h /usr/include/X11/Xosdefs.h
nam/nam-packet.o: nam/nam-edge.h /usr/include/math.h
nam/nam-packet.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
nam/nam-packet.o: /usr/include/bits/mathcalls.h
nam/nam-packet.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
nam/nam-packet.o: nam/animation.h nam/bbox.h nam/state.h nam/nam-packet.h
nam/nam-queue.o: /usr/include/math.h /usr/include/features.h
nam/nam-queue.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
nam/nam-queue.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
nam/nam-queue.o: /usr/include/bits/mathcalls.h
nam/nam-queue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
nam/nam-queue.o: nam/netview.h nam/netmodel.h nam/nam-trace.h nam/transform.h
nam/nam-queue.o: /usr/include/tk.h /usr/include/tcl.h /usr/include/stdio.h
nam/nam-queue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
nam/nam-queue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
nam/nam-queue.o: /usr/include/bits/types.h /usr/include/libio.h
nam/nam-queue.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
nam/nam-queue.o: /usr/include/X11/Xlib.h /usr/include/sys/types.h
nam/nam-queue.o: /usr/include/time.h /usr/include/endian.h
nam/nam-queue.o: /usr/include/bits/endian.h /usr/include/sys/select.h
nam/nam-queue.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
nam/nam-queue.o: /usr/include/sys/sysmacros.h /usr/include/X11/X.h
nam/nam-queue.o: /usr/include/X11/Xfuncproto.h /usr/include/X11/Xosdefs.h
nam/nam-queue.o: nam/nam-queue.h nam/animation.h nam/bbox.h nam/state.h
nam/nam-queue.o: nam/nam-drop.h
nam/nam-trace.o: /usr/include/sys/types.h /usr/include/features.h
nam/nam-trace.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
nam/nam-trace.o: /usr/include/bits/types.h
nam/nam-trace.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
nam/nam-trace.o: /usr/include/time.h /usr/include/endian.h
nam/nam-trace.o: /usr/include/bits/endian.h /usr/include/sys/select.h
nam/nam-trace.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
nam/nam-trace.o: /usr/include/sys/sysmacros.h /usr/include/unistd.h
nam/nam-trace.o: /usr/include/bits/posix_opt.h /usr/include/bits/confname.h
nam/nam-trace.o: /usr/include/getopt.h /usr/include/sys/stat.h
nam/nam-trace.o: /usr/include/bits/stat.h /usr/include/sys/file.h
nam/nam-trace.o: /usr/include/fcntl.h /usr/include/bits/fcntl.h
nam/nam-trace.o: /usr/include/stdlib.h /usr/include/alloca.h
nam/nam-trace.o: /usr/include/ctype.h nam/nam-trace.h nam/state.h
nam/paint.o: nam/paint.h /usr/include/tk.h /usr/include/tcl.h
nam/paint.o: /usr/include/stdio.h /usr/include/features.h
nam/paint.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
nam/paint.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
nam/paint.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
nam/paint.o: /usr/include/bits/types.h /usr/include/libio.h
nam/paint.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
nam/paint.o: /usr/include/X11/Xlib.h /usr/include/sys/types.h
nam/paint.o: /usr/include/time.h /usr/include/endian.h
nam/paint.o: /usr/include/bits/endian.h /usr/include/sys/select.h
nam/paint.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
nam/paint.o: /usr/include/sys/sysmacros.h /usr/include/X11/X.h
nam/paint.o: /usr/include/X11/Xfuncproto.h /usr/include/X11/Xosdefs.h
nam/state.o: nam/state.h
nam/transform.o: /usr/include/math.h /usr/include/features.h
nam/transform.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
nam/transform.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
nam/transform.o: /usr/include/bits/mathcalls.h
nam/transform.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
nam/transform.o: nam/transform.h
nam/netview.o: /usr/include/stdlib.h /usr/include/features.h
nam/netview.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
nam/netview.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
nam/netview.o: /usr/include/sys/types.h /usr/include/bits/types.h
nam/netview.o: /usr/include/time.h /usr/include/endian.h
nam/netview.o: /usr/include/bits/endian.h /usr/include/sys/select.h
nam/netview.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
nam/netview.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
nam/netview.o: /usr/include/ctype.h /usr/include/tk.h /usr/include/tcl.h
nam/netview.o: /usr/include/stdio.h
nam/netview.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
nam/netview.o: /usr/include/libio.h /usr/include/_G_config.h
nam/netview.o: /usr/include/bits/stdio_lim.h /usr/include/X11/Xlib.h
nam/netview.o: /usr/include/X11/X.h /usr/include/X11/Xfuncproto.h
nam/netview.o: /usr/include/X11/Xosdefs.h nam/bbox.h nam/netview.h
nam/netview.o: nam/netmodel.h nam/nam-trace.h nam/transform.h nam/paint.h
nam/netview.o: nam/nam-packet.h nam/animation.h nam/state.h
nam/netmodel.o: /usr/include/stdlib.h /usr/include/features.h
nam/netmodel.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
nam/netmodel.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
nam/netmodel.o: /usr/include/sys/types.h /usr/include/bits/types.h
nam/netmodel.o: /usr/include/time.h /usr/include/endian.h
nam/netmodel.o: /usr/include/bits/endian.h /usr/include/sys/select.h
nam/netmodel.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
nam/netmodel.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
nam/netmodel.o: /usr/include/ctype.h /usr/include/math.h
nam/netmodel.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
nam/netmodel.o: /usr/include/bits/mathcalls.h
nam/netmodel.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
nam/netmodel.o: nam/netview.h nam/netmodel.h nam/nam-trace.h nam/transform.h
nam/netmodel.o: /usr/include/tk.h /usr/include/tcl.h /usr/include/stdio.h
nam/netmodel.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
nam/netmodel.o: /usr/include/libio.h /usr/include/_G_config.h
nam/netmodel.o: /usr/include/bits/stdio_lim.h /usr/include/X11/Xlib.h
nam/netmodel.o: /usr/include/X11/X.h /usr/include/X11/Xfuncproto.h
nam/netmodel.o: /usr/include/X11/Xosdefs.h nam/animation.h nam/bbox.h
nam/netmodel.o: nam/state.h nam/nam-queue.h nam/nam-drop.h nam/nam-packet.h
nam/netmodel.o: nam/nam-edge.h nam/nam-node.h nam/paint.h
cmu/channel.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/channel.o: ./delay.h /usr/include/assert.h /usr/include/features.h
cmu/channel.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h packet.h
cmu/channel.o: config.h /usr/include/stdlib.h
cmu/channel.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/channel.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/channel.o: /usr/include/time.h /usr/include/endian.h
cmu/channel.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/channel.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/channel.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h scheduler.h
cmu/channel.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/channel.o: ./cmu/debug.h /usr/include/string.h queue.h connector.h ip.h
cmu/channel.o: trace.h ./cmu/net-if.h ./cmu/channel.h ./cmu/arp.h
cmu/channel.o: ./cmu/topography.h ./cmu/node.h
cmu/ll.o: ./delay.h /usr/include/assert.h /usr/include/features.h
cmu/ll.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h packet.h config.h
cmu/ll.o: /usr/include/stdlib.h
cmu/ll.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/ll.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/ll.o: /usr/include/time.h /usr/include/endian.h
cmu/ll.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/ll.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/ll.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h scheduler.h
cmu/ll.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/ll.o: ./cmu/debug.h /usr/include/string.h queue.h connector.h ip.h
cmu/ll.o: ./cmu/debug.h ./cmu/list.h ./cmu/arp.h ./cmu/topography.h trace.h
cmu/ll.o: ./cmu/node.h ./cmu/net-if.h ./cmu/channel.h ./cmu/topography.h
cmu/ll.o: ./cmu/arp.h ./cmu/mac.h ./cmu/ll.h ./cmu/node.h ./cmu/god.h
cmu/ll.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/ll.o: ./cmu/marshall.h ./cmu/ll.h random.h /usr/include/math.h
cmu/ll.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/ll.o: /usr/include/bits/mathcalls.h
cmu/ll.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/ll.o: rng.h ./cmu/mac-802_11.h ./cmu/mac-timers.h ./cmu/cbrp/hdr_cbrp.h
cmu/ll.o: ./cmu/dsr/hdr_sr.h
cmu/mac.o: ./delay.h /usr/include/assert.h /usr/include/features.h
cmu/mac.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h packet.h
cmu/mac.o: config.h /usr/include/stdlib.h
cmu/mac.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/mac.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/mac.o: /usr/include/time.h /usr/include/endian.h
cmu/mac.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/mac.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/mac.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h scheduler.h
cmu/mac.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/mac.o: ./cmu/debug.h /usr/include/string.h queue.h connector.h ip.h
cmu/mac.o: random.h /usr/include/math.h /usr/include/bits/huge_val.h
cmu/mac.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
cmu/mac.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/mac.o: rng.h ./cmu/god.h
cmu/mac.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/mac.o: trace.h ./cmu/node.h ./cmu/net-if.h ./cmu/channel.h
cmu/mac.o: ./cmu/topography.h ./cmu/arp.h ./cmu/debug.h ./cmu/arp.h
cmu/mac.o: ./cmu/ll.h ./cmu/mac.h ./cmu/ll.h ./cmu/marshall.h
cmu/modulation.o: /usr/include/math.h /usr/include/features.h
cmu/modulation.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/modulation.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/modulation.o: /usr/include/bits/mathcalls.h
cmu/modulation.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/modulation.o: /usr/include/stdlib.h
cmu/modulation.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/modulation.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/modulation.o: /usr/include/time.h /usr/include/endian.h
cmu/modulation.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/modulation.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/modulation.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/modulation.o: ./cmu/debug.h /usr/include/assert.h /usr/include/string.h
cmu/modulation.o: ./cmu/modulation.h
cmu/arp.o: /usr/include/errno.h /usr/include/features.h
cmu/arp.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/arp.o: /usr/include/bits/errno.h /usr/include/linux/errno.h
cmu/arp.o: /usr/include/asm/errno.h ./delay.h /usr/include/assert.h packet.h
cmu/arp.o: config.h /usr/include/stdlib.h
cmu/arp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/arp.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/arp.o: /usr/include/time.h /usr/include/endian.h
cmu/arp.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/arp.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/arp.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h scheduler.h
cmu/arp.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/arp.o: ./cmu/debug.h /usr/include/string.h queue.h connector.h ip.h
cmu/arp.o: ./cmu/debug.h ./cmu/mac.h ./cmu/ll.h ./cmu/arp.h ./cmu/node.h
cmu/arp.o: trace.h ./cmu/net-if.h ./cmu/channel.h ./cmu/topography.h
cmu/arp.o: ./cmu/god.h
cmu/arp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/arp.o: ./cmu/marshall.h ./cmu/arp.h ./cmu/topography.h ./cmu/cmu-trace.h
cmu/arp.o: ./cmu/god.h ./cmu/node.h ./cmu/ll.h
cmu/node.o: /usr/include/math.h /usr/include/features.h
cmu/node.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/node.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/node.o: /usr/include/bits/mathcalls.h
cmu/node.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/node.o: /usr/include/stdlib.h
cmu/node.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/node.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/node.o: /usr/include/time.h /usr/include/endian.h
cmu/node.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/node.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/node.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h connector.h
cmu/node.o: ./object.h scheduler.h ./delay.h /usr/include/assert.h packet.h
cmu/node.o: config.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/node.o: ./cmu/debug.h /usr/include/string.h queue.h ip.h random.h rng.h
cmu/node.o: ./cmu/debug.h ./cmu/arp.h ./cmu/topography.h trace.h ./cmu/node.h
cmu/node.o: ./cmu/net-if.h ./cmu/channel.h ./cmu/topography.h ./cmu/arp.h
cmu/node.o: ./cmu/ll.h ./cmu/node.h ./cmu/god.h
cmu/node.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/node.o: ./cmu/mac.h ./cmu/ll.h ./cmu/marshall.h ./cmu/propagation.h
cmu/node.o: ./cmu/sharedmedia.h ./cmu/omni-antenna.h
cmu/net-if.o: /usr/include/math.h /usr/include/features.h
cmu/net-if.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/net-if.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/net-if.o: /usr/include/bits/mathcalls.h
cmu/net-if.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/net-if.o: ./object.h scheduler.h packet.h config.h /usr/include/stdlib.h
cmu/net-if.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/net-if.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/net-if.o: /usr/include/time.h /usr/include/endian.h
cmu/net-if.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/net-if.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/net-if.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/net-if.o: /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/net-if.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h
cmu/net-if.o: ./cmu/channel.h ./cmu/net-if.h ./cmu/node.h trace.h connector.h
cmu/net-if.o: ./cmu/topography.h ./cmu/arp.h ./delay.h queue.h ip.h
cmu/net-if.o: ./cmu/propagation.h ./cmu/sharedmedia.h ./cmu/omni-antenna.h
cmu/sharedmedia.o: /usr/include/math.h /usr/include/features.h
cmu/sharedmedia.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/sharedmedia.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/sharedmedia.o: /usr/include/bits/mathcalls.h
cmu/sharedmedia.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/sharedmedia.o: packet.h config.h /usr/include/stdlib.h
cmu/sharedmedia.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/sharedmedia.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/sharedmedia.o: /usr/include/time.h /usr/include/endian.h
cmu/sharedmedia.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/sharedmedia.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/sharedmedia.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/sharedmedia.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
cmu/sharedmedia.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/sharedmedia.o: /usr/include/string.h ./cmu/node.h trace.h connector.h
cmu/sharedmedia.o: ./cmu/net-if.h ./cmu/channel.h ./cmu/topography.h
cmu/sharedmedia.o: ./cmu/arp.h ./delay.h queue.h ip.h ./cmu/propagation.h
cmu/sharedmedia.o: ./cmu/sharedmedia.h ./cmu/omni-antenna.h
cmu/sharedmedia.o: ./cmu/modulation.h
cmu/antenna.o: ./cmu/antenna.h ./object.h scheduler.h ./cmu/list.h
cmu/omni-antenna.o: ./cmu/omni-antenna.h ./cmu/antenna.h ./object.h
cmu/omni-antenna.o: scheduler.h ./cmu/list.h
cmu/propagation.o: /usr/include/stdio.h /usr/include/features.h
cmu/propagation.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/propagation.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/propagation.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/propagation.o: /usr/include/bits/types.h /usr/include/libio.h
cmu/propagation.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
cmu/propagation.o: ./cmu/topography.h ./object.h scheduler.h ./cmu/net-if.h
cmu/propagation.o: /usr/include/assert.h ./cmu/list.h ./cmu/channel.h
cmu/propagation.o: packet.h config.h /usr/include/stdlib.h
cmu/propagation.o: /usr/include/sys/types.h /usr/include/time.h
cmu/propagation.o: /usr/include/endian.h /usr/include/bits/endian.h
cmu/propagation.o: /usr/include/sys/select.h /usr/include/bits/select.h
cmu/propagation.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
cmu/propagation.o: /usr/include/alloca.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/propagation.o: ./cmu/debug.h /usr/include/string.h ./cmu/sharedmedia.h
cmu/propagation.o: ./cmu/omni-antenna.h ./cmu/propagation.h
cmu/tworayground.o: /usr/include/math.h /usr/include/features.h
cmu/tworayground.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/tworayground.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/tworayground.o: /usr/include/bits/mathcalls.h
cmu/tworayground.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/tworayground.o: ./delay.h /usr/include/assert.h packet.h config.h
cmu/tworayground.o: /usr/include/stdlib.h
cmu/tworayground.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/tworayground.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/tworayground.o: /usr/include/time.h /usr/include/endian.h
cmu/tworayground.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/tworayground.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/tworayground.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/tworayground.o: scheduler.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/tworayground.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h
cmu/tworayground.o: queue.h connector.h ip.h ./cmu/node.h trace.h
cmu/tworayground.o: ./cmu/net-if.h ./cmu/channel.h ./cmu/topography.h
cmu/tworayground.o: ./cmu/arp.h ./cmu/sharedmedia.h ./cmu/omni-antenna.h
cmu/tworayground.o: ./cmu/propagation.h ./cmu/tworayground.h
cmu/dem.o: /usr/include/ctype.h /usr/include/features.h
cmu/dem.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/dem.o: /usr/include/bits/types.h
cmu/dem.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/dem.o: /usr/include/endian.h /usr/include/bits/endian.h
cmu/dem.o: /usr/include/errno.h /usr/include/bits/errno.h
cmu/dem.o: /usr/include/linux/errno.h /usr/include/asm/errno.h
cmu/dem.o: /usr/include/stdlib.h /usr/include/sys/types.h /usr/include/time.h
cmu/dem.o: /usr/include/sys/select.h /usr/include/bits/select.h
cmu/dem.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
cmu/dem.o: /usr/include/alloca.h /usr/include/stdio.h
cmu/dem.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/dem.o: /usr/include/libio.h /usr/include/_G_config.h
cmu/dem.o: /usr/include/bits/stdio_lim.h /usr/include/string.h ./cmu/dem.h
cmu/topography.o: /usr/include/math.h /usr/include/features.h
cmu/topography.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/topography.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/topography.o: /usr/include/bits/mathcalls.h
cmu/topography.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/topography.o: /usr/include/stdlib.h
cmu/topography.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/topography.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/topography.o: /usr/include/time.h /usr/include/endian.h
cmu/topography.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/topography.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/topography.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/topography.o: ./object.h scheduler.h ./cmu/dem.h ./cmu/topography.h
cmu/mac-802_3.o: ./delay.h /usr/include/assert.h /usr/include/features.h
cmu/mac-802_3.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h packet.h
cmu/mac-802_3.o: config.h /usr/include/stdlib.h
cmu/mac-802_3.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/mac-802_3.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/mac-802_3.o: /usr/include/time.h /usr/include/endian.h
cmu/mac-802_3.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/mac-802_3.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/mac-802_3.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/mac-802_3.o: scheduler.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/mac-802_3.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h queue.h
cmu/mac-802_3.o: connector.h ip.h random.h /usr/include/math.h
cmu/mac-802_3.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/mac-802_3.o: /usr/include/bits/mathcalls.h
cmu/mac-802_3.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/mac-802_3.o: rng.h ./cmu/arp.h ./cmu/ll.h ./cmu/node.h trace.h
cmu/mac-802_3.o: ./cmu/net-if.h ./cmu/channel.h ./cmu/topography.h
cmu/mac-802_3.o: ./cmu/god.h
cmu/mac-802_3.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/mac-802_3.o: ./cmu/mac.h ./cmu/marshall.h ./cmu/mac-802_3.h
cmu/mac-802_11.o: ./delay.h /usr/include/assert.h /usr/include/features.h
cmu/mac-802_11.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h packet.h
cmu/mac-802_11.o: config.h /usr/include/stdlib.h
cmu/mac-802_11.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/mac-802_11.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/mac-802_11.o: /usr/include/time.h /usr/include/endian.h
cmu/mac-802_11.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/mac-802_11.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/mac-802_11.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/mac-802_11.o: scheduler.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/mac-802_11.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h queue.h
cmu/mac-802_11.o: connector.h ip.h random.h /usr/include/math.h
cmu/mac-802_11.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/mac-802_11.o: /usr/include/bits/mathcalls.h
cmu/mac-802_11.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/mac-802_11.o: rng.h ./cmu/arp.h ./cmu/ll.h ./cmu/node.h trace.h
cmu/mac-802_11.o: ./cmu/net-if.h ./cmu/channel.h ./cmu/topography.h
cmu/mac-802_11.o: ./cmu/god.h
cmu/mac-802_11.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/mac-802_11.o: ./cmu/mac.h ./cmu/marshall.h ./cmu/mac-timers.h
cmu/mac-802_11.o: ./cmu/mac-802_11.h ./cmu/cmu-trace.h ./cmu/god.h
cmu/mac-timers.o: ./delay.h /usr/include/assert.h /usr/include/features.h
cmu/mac-timers.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h packet.h
cmu/mac-timers.o: config.h /usr/include/stdlib.h
cmu/mac-timers.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/mac-timers.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/mac-timers.o: /usr/include/time.h /usr/include/endian.h
cmu/mac-timers.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/mac-timers.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/mac-timers.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/mac-timers.o: scheduler.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/mac-timers.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h queue.h
cmu/mac-timers.o: connector.h ip.h random.h /usr/include/math.h
cmu/mac-timers.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/mac-timers.o: /usr/include/bits/mathcalls.h
cmu/mac-timers.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/mac-timers.o: rng.h ./cmu/debug.h ./cmu/arp.h ./cmu/ll.h ./cmu/arp.h
cmu/mac-timers.o: ./cmu/node.h trace.h ./cmu/net-if.h ./cmu/channel.h
cmu/mac-timers.o: ./cmu/topography.h ./cmu/god.h
cmu/mac-timers.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/mac-timers.o: ./cmu/mac.h ./cmu/ll.h ./cmu/marshall.h ./cmu/mac-timers.h
cmu/mac-timers.o: ./cmu/mac-802_11.h ./cmu/mac-timers.h
cmu/priqueue.o: ./object.h scheduler.h queue.h connector.h packet.h config.h
cmu/priqueue.o: /usr/include/stdlib.h /usr/include/features.h
cmu/priqueue.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/priqueue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/priqueue.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/priqueue.o: /usr/include/time.h /usr/include/endian.h
cmu/priqueue.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/priqueue.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/priqueue.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/priqueue.o: /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/priqueue.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h ip.h
cmu/priqueue.o: drop-tail.h ./cmu/cmu-trace.h trace.h ./cmu/god.h
cmu/priqueue.o: cmu/priqueue.h
cmu/rtqueue.o: /usr/include/assert.h /usr/include/features.h
cmu/rtqueue.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/rtqueue.o: ./cmu/rtqueue.h packet.h config.h /usr/include/stdlib.h
cmu/rtqueue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/rtqueue.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/rtqueue.o: /usr/include/time.h /usr/include/endian.h
cmu/rtqueue.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/rtqueue.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/rtqueue.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h scheduler.h
cmu/rtqueue.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/rtqueue.o: ./cmu/debug.h /usr/include/string.h agent.h connector.h
cmu/rtqueue.o: timer-handler.h ./cmu/cmu-trace.h trace.h ./cmu/god.h
cmu/rttable.o: ./cmu/rttable.h /usr/include/assert.h /usr/include/features.h
cmu/rttable.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/rttable.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/rttable.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/rttable.o: /usr/include/time.h /usr/include/endian.h
cmu/rttable.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/rttable.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/rttable.o: /usr/include/sys/sysmacros.h config.h /usr/include/stdlib.h
cmu/rttable.o: /usr/include/alloca.h ./cmu/list.h scheduler.h
cmu/god.o: ./object.h scheduler.h packet.h config.h /usr/include/stdlib.h
cmu/god.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/god.o: /usr/include/gnu/stubs.h
cmu/god.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/god.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/god.o: /usr/include/time.h /usr/include/endian.h
cmu/god.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/god.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/god.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/god.o: /usr/include/assert.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/god.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h ip.h
cmu/god.o: ./cmu/god.h
cmu/cmu-trace.o: packet.h config.h /usr/include/stdlib.h
cmu/cmu-trace.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/cmu-trace.o: /usr/include/gnu/stubs.h
cmu/cmu-trace.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/cmu-trace.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/cmu-trace.o: /usr/include/time.h /usr/include/endian.h
cmu/cmu-trace.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/cmu-trace.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/cmu-trace.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/cmu-trace.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
cmu/cmu-trace.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/cmu-trace.o: /usr/include/string.h ip.h tcp.h agent.h connector.h
cmu/cmu-trace.o: timer-handler.h rtp.h ./cmu/arp.h ./delay.h queue.h
cmu/cmu-trace.o: ./cmu/marshall.h ./cmu/tora/tora_packet.h
cmu/cmu-trace.o: ./cmu/aodv/aodv_packet.h ./cmu/dsr/hdr_sr.h
cmu/cmu-trace.o: ./cmu/cbrp/hdr_cbrp.h ./cmu/imep/imep_spec.h ./cmu/mac.h
cmu/cmu-trace.o: ./cmu/ll.h ./cmu/arp.h ./cmu/node.h trace.h ./cmu/net-if.h
cmu/cmu-trace.o: ./cmu/channel.h ./cmu/topography.h ./cmu/god.h
cmu/cmu-trace.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/cmu-trace.o: ./cmu/mac-802_11.h ./cmu/mac-timers.h ./cmu/cmu-trace.h
cmu/cmu-trace.o: ./cmu/god.h
cmu/tora/tora.o: agent.h config.h /usr/include/stdlib.h
cmu/tora/tora.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/tora/tora.o: /usr/include/gnu/stubs.h
cmu/tora/tora.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/tora/tora.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/tora/tora.o: /usr/include/time.h /usr/include/endian.h
cmu/tora/tora.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/tora/tora.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/tora/tora.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
cmu/tora/tora.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
cmu/tora/tora.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/tora/tora.o: /usr/include/string.h connector.h timer-handler.h random.h
cmu/tora/tora.o: /usr/include/math.h /usr/include/bits/huge_val.h
cmu/tora/tora.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
cmu/tora/tora.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/tora/tora.o: rng.h trace.h ./cmu/ll.h ./delay.h queue.h ip.h ./cmu/arp.h
cmu/tora/tora.o: ./cmu/node.h ./cmu/net-if.h ./cmu/channel.h
cmu/tora/tora.o: ./cmu/topography.h ./cmu/god.h
cmu/tora/tora.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/tora/tora.o: ./cmu/priqueue.h drop-tail.h ./cmu/tora/tora_packet.h
cmu/tora/tora.o: ./cmu/tora/tora.h ./cmu/cmu-trace.h ./cmu/god.h
cmu/tora/tora.o: ./cmu/rtqueue.h ./cmu/list.h ./cmu/rtproto/rtproto.h
cmu/tora/tora.o: ./cmu/imep/imep.h ./cmu/imep/rxmit_queue.h
cmu/tora/tora.o: ./cmu/imep/dest_queue.h ./cmu/imep/imep_stats.h
cmu/tora/tora.o: ./cmu/imep/imep_spec.h ./cmu/tora/tora_neighbor.h
cmu/tora/tora.o: ./cmu/tora/tora_dest.h
cmu/tora/tora_api.o: ./cmu/tora/tora.h packet.h config.h
cmu/tora/tora_api.o: /usr/include/stdlib.h /usr/include/features.h
cmu/tora/tora_api.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/tora/tora_api.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/tora/tora_api.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/tora/tora_api.o: /usr/include/time.h /usr/include/endian.h
cmu/tora/tora_api.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/tora/tora_api.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/tora/tora_api.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/tora/tora_api.o: scheduler.h /usr/include/assert.h ./object.h
cmu/tora/tora_api.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/tora/tora_api.o: ./cmu/debug.h /usr/include/string.h ip.h
cmu/tora/tora_api.o: ./cmu/cmu-trace.h trace.h connector.h ./cmu/god.h
cmu/tora/tora_api.o: ./cmu/priqueue.h queue.h drop-tail.h ./cmu/rtqueue.h
cmu/tora/tora_api.o: agent.h timer-handler.h ./cmu/list.h
cmu/tora/tora_api.o: ./cmu/rtproto/rtproto.h ./cmu/imep/imep.h
cmu/tora/tora_api.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/tora/tora_api.o: ./cmu/imep/rxmit_queue.h ./cmu/imep/dest_queue.h
cmu/tora/tora_api.o: ./cmu/imep/imep_stats.h ./cmu/imep/imep_spec.h
cmu/tora/tora_api.o: ./cmu/tora/tora_packet.h ./cmu/tora/tora_neighbor.h
cmu/tora/tora_api.o: ./cmu/tora/tora_dest.h
cmu/tora/tora_io.o: ./cmu/tora/tora_packet.h config.h /usr/include/stdlib.h
cmu/tora/tora_io.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/tora/tora_io.o: /usr/include/gnu/stubs.h
cmu/tora/tora_io.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/tora/tora_io.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/tora/tora_io.o: /usr/include/time.h /usr/include/endian.h
cmu/tora/tora_io.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/tora/tora_io.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/tora/tora_io.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/tora/tora_io.o: ./cmu/tora/tora.h packet.h scheduler.h
cmu/tora/tora_io.o: /usr/include/assert.h ./object.h ./cmu/list.h
cmu/tora/tora_io.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/tora/tora_io.o: /usr/include/string.h ip.h ./cmu/cmu-trace.h trace.h
cmu/tora/tora_io.o: connector.h ./cmu/god.h ./cmu/priqueue.h queue.h
cmu/tora/tora_io.o: drop-tail.h ./cmu/rtqueue.h agent.h timer-handler.h
cmu/tora/tora_io.o: ./cmu/list.h ./cmu/rtproto/rtproto.h ./cmu/imep/imep.h
cmu/tora/tora_io.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/tora/tora_io.o: ./cmu/imep/rxmit_queue.h ./cmu/imep/dest_queue.h
cmu/tora/tora_io.o: ./cmu/imep/imep_stats.h ./cmu/imep/imep_spec.h
cmu/tora/tora_io.o: ./cmu/tora/tora_neighbor.h ./cmu/tora/tora_dest.h
cmu/tora/tora_neighbor.o: agent.h config.h /usr/include/stdlib.h
cmu/tora/tora_neighbor.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/tora/tora_neighbor.o: /usr/include/gnu/stubs.h
cmu/tora/tora_neighbor.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/tora/tora_neighbor.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/tora/tora_neighbor.o: /usr/include/time.h /usr/include/endian.h
cmu/tora/tora_neighbor.o: /usr/include/bits/endian.h
cmu/tora/tora_neighbor.o: /usr/include/sys/select.h
cmu/tora/tora_neighbor.o: /usr/include/bits/select.h
cmu/tora/tora_neighbor.o: /usr/include/bits/sigset.h
cmu/tora/tora_neighbor.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/tora/tora_neighbor.o: packet.h scheduler.h /usr/include/assert.h
cmu/tora/tora_neighbor.o: ./object.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/tora/tora_neighbor.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h
cmu/tora/tora_neighbor.o: connector.h timer-handler.h random.h
cmu/tora/tora_neighbor.o: /usr/include/math.h /usr/include/bits/huge_val.h
cmu/tora/tora_neighbor.o: /usr/include/bits/mathdef.h
cmu/tora/tora_neighbor.o: /usr/include/bits/mathcalls.h
cmu/tora/tora_neighbor.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/tora/tora_neighbor.o: rng.h trace.h ./cmu/ll.h ./delay.h queue.h ip.h
cmu/tora/tora_neighbor.o: ./cmu/arp.h ./cmu/node.h ./cmu/net-if.h
cmu/tora/tora_neighbor.o: ./cmu/channel.h ./cmu/topography.h ./cmu/god.h
cmu/tora/tora_neighbor.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/tora/tora_neighbor.o: ./cmu/priqueue.h drop-tail.h
cmu/tora/tora_neighbor.o: ./cmu/tora/tora_packet.h ./cmu/tora/tora.h
cmu/tora/tora_neighbor.o: ./cmu/cmu-trace.h ./cmu/god.h ./cmu/rtqueue.h
cmu/tora/tora_neighbor.o: ./cmu/list.h ./cmu/rtproto/rtproto.h
cmu/tora/tora_neighbor.o: ./cmu/imep/imep.h ./cmu/imep/rxmit_queue.h
cmu/tora/tora_neighbor.o: ./cmu/imep/dest_queue.h ./cmu/imep/imep_stats.h
cmu/tora/tora_neighbor.o: ./cmu/imep/imep_spec.h ./cmu/tora/tora_neighbor.h
cmu/tora/tora_neighbor.o: ./cmu/tora/tora_dest.h
cmu/tora/tora_dest.o: agent.h config.h /usr/include/stdlib.h
cmu/tora/tora_dest.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/tora/tora_dest.o: /usr/include/gnu/stubs.h
cmu/tora/tora_dest.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/tora/tora_dest.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/tora/tora_dest.o: /usr/include/time.h /usr/include/endian.h
cmu/tora/tora_dest.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/tora/tora_dest.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/tora/tora_dest.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/tora/tora_dest.o: packet.h scheduler.h /usr/include/assert.h ./object.h
cmu/tora/tora_dest.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/tora/tora_dest.o: ./cmu/debug.h /usr/include/string.h connector.h
cmu/tora/tora_dest.o: timer-handler.h random.h /usr/include/math.h
cmu/tora/tora_dest.o: /usr/include/bits/huge_val.h
cmu/tora/tora_dest.o: /usr/include/bits/mathdef.h
cmu/tora/tora_dest.o: /usr/include/bits/mathcalls.h
cmu/tora/tora_dest.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/tora/tora_dest.o: rng.h trace.h ./cmu/ll.h ./delay.h queue.h ip.h
cmu/tora/tora_dest.o: ./cmu/arp.h ./cmu/node.h ./cmu/net-if.h ./cmu/channel.h
cmu/tora/tora_dest.o: ./cmu/topography.h ./cmu/god.h
cmu/tora/tora_dest.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/tora/tora_dest.o: ./cmu/priqueue.h drop-tail.h ./cmu/tora/tora_packet.h
cmu/tora/tora_dest.o: ./cmu/tora/tora.h ./cmu/cmu-trace.h ./cmu/god.h
cmu/tora/tora_dest.o: ./cmu/rtqueue.h ./cmu/list.h ./cmu/rtproto/rtproto.h
cmu/tora/tora_dest.o: ./cmu/imep/imep.h ./cmu/imep/rxmit_queue.h
cmu/tora/tora_dest.o: ./cmu/imep/dest_queue.h ./cmu/imep/imep_stats.h
cmu/tora/tora_dest.o: ./cmu/imep/imep_spec.h ./cmu/tora/tora_neighbor.h
cmu/tora/tora_dest.o: ./cmu/tora/tora_dest.h
cmu/tora/tora_logs.o: agent.h config.h /usr/include/stdlib.h
cmu/tora/tora_logs.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/tora/tora_logs.o: /usr/include/gnu/stubs.h
cmu/tora/tora_logs.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/tora/tora_logs.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/tora/tora_logs.o: /usr/include/time.h /usr/include/endian.h
cmu/tora/tora_logs.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/tora/tora_logs.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/tora/tora_logs.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/tora/tora_logs.o: packet.h scheduler.h /usr/include/assert.h ./object.h
cmu/tora/tora_logs.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/tora/tora_logs.o: ./cmu/debug.h /usr/include/string.h connector.h
cmu/tora/tora_logs.o: timer-handler.h random.h /usr/include/math.h
cmu/tora/tora_logs.o: /usr/include/bits/huge_val.h
cmu/tora/tora_logs.o: /usr/include/bits/mathdef.h
cmu/tora/tora_logs.o: /usr/include/bits/mathcalls.h
cmu/tora/tora_logs.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/tora/tora_logs.o: rng.h trace.h ./cmu/ll.h ./delay.h queue.h ip.h
cmu/tora/tora_logs.o: ./cmu/arp.h ./cmu/node.h ./cmu/net-if.h ./cmu/channel.h
cmu/tora/tora_logs.o: ./cmu/topography.h ./cmu/god.h
cmu/tora/tora_logs.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/tora/tora_logs.o: ./cmu/priqueue.h drop-tail.h ./cmu/tora/tora_packet.h
cmu/tora/tora_logs.o: ./cmu/tora/tora.h ./cmu/cmu-trace.h ./cmu/god.h
cmu/tora/tora_logs.o: ./cmu/rtqueue.h ./cmu/list.h ./cmu/rtproto/rtproto.h
cmu/tora/tora_logs.o: ./cmu/imep/imep.h ./cmu/imep/rxmit_queue.h
cmu/tora/tora_logs.o: ./cmu/imep/dest_queue.h ./cmu/imep/imep_stats.h
cmu/tora/tora_logs.o: ./cmu/imep/imep_spec.h ./cmu/tora/tora_neighbor.h
cmu/tora/tora_logs.o: ./cmu/tora/tora_dest.h
cmu/imep/imep.o: packet.h config.h /usr/include/stdlib.h
cmu/imep/imep.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/imep/imep.o: /usr/include/gnu/stubs.h
cmu/imep/imep.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/imep/imep.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/imep/imep.o: /usr/include/time.h /usr/include/endian.h
cmu/imep/imep.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/imep/imep.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/imep/imep.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/imep/imep.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
cmu/imep/imep.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/imep/imep.o: /usr/include/string.h ip.h random.h /usr/include/math.h
cmu/imep/imep.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/imep/imep.o: /usr/include/bits/mathcalls.h
cmu/imep/imep.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/imep/imep.o: rng.h ./cmu/cmu-trace.h trace.h connector.h ./cmu/god.h
cmu/imep/imep.o: ./cmu/imep/imep.h
cmu/imep/imep.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/imep/imep.o: agent.h timer-handler.h drop-tail.h queue.h
cmu/imep/imep.o: ./cmu/rtproto/rtproto.h ./cmu/imep/rxmit_queue.h
cmu/imep/imep.o: ./cmu/imep/dest_queue.h ./cmu/imep/imep_stats.h
cmu/imep/imep.o: ./cmu/imep/imep_spec.h
cmu/imep/imep_api.o: ./cmu/imep/imep.h
cmu/imep/imep_api.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/imep/imep_api.o: /usr/include/sys/types.h /usr/include/features.h
cmu/imep/imep_api.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/imep/imep_api.o: /usr/include/bits/types.h
cmu/imep/imep_api.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/imep/imep_api.o: /usr/include/time.h /usr/include/endian.h
cmu/imep/imep_api.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/imep/imep_api.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/imep/imep_api.o: /usr/include/sys/sysmacros.h config.h
cmu/imep/imep_api.o: /usr/include/stdlib.h /usr/include/alloca.h agent.h
cmu/imep/imep_api.o: packet.h scheduler.h /usr/include/assert.h ./object.h
cmu/imep/imep_api.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/imep/imep_api.o: ./cmu/debug.h /usr/include/string.h connector.h
cmu/imep/imep_api.o: timer-handler.h drop-tail.h queue.h ip.h trace.h
cmu/imep/imep_api.o: ./cmu/rtproto/rtproto.h ./cmu/imep/rxmit_queue.h
cmu/imep/imep_api.o: ./cmu/imep/dest_queue.h ./cmu/imep/imep_stats.h
cmu/imep/imep_api.o: ./cmu/imep/imep_spec.h
cmu/imep/imep_rt.o: ./cmu/imep/imep.h
cmu/imep/imep_rt.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/imep/imep_rt.o: /usr/include/sys/types.h /usr/include/features.h
cmu/imep/imep_rt.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/imep/imep_rt.o: /usr/include/bits/types.h
cmu/imep/imep_rt.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/imep/imep_rt.o: /usr/include/time.h /usr/include/endian.h
cmu/imep/imep_rt.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/imep/imep_rt.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/imep/imep_rt.o: /usr/include/sys/sysmacros.h config.h
cmu/imep/imep_rt.o: /usr/include/stdlib.h /usr/include/alloca.h agent.h
cmu/imep/imep_rt.o: packet.h scheduler.h /usr/include/assert.h ./object.h
cmu/imep/imep_rt.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/imep/imep_rt.o: ./cmu/debug.h /usr/include/string.h connector.h
cmu/imep/imep_rt.o: timer-handler.h drop-tail.h queue.h ip.h trace.h
cmu/imep/imep_rt.o: ./cmu/rtproto/rtproto.h ./cmu/imep/rxmit_queue.h
cmu/imep/imep_rt.o: ./cmu/imep/dest_queue.h ./cmu/imep/imep_stats.h
cmu/imep/imep_rt.o: ./cmu/imep/imep_spec.h ./cmu/tora/tora_packet.h
cmu/imep/imep_io.o: random.h /usr/include/math.h /usr/include/features.h
cmu/imep/imep_io.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/imep/imep_io.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/imep/imep_io.o: /usr/include/bits/mathcalls.h
cmu/imep/imep_io.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/imep/imep_io.o: config.h /usr/include/stdlib.h
cmu/imep/imep_io.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/imep/imep_io.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/imep/imep_io.o: /usr/include/time.h /usr/include/endian.h
cmu/imep/imep_io.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/imep/imep_io.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/imep/imep_io.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h rng.h
cmu/imep/imep_io.o: packet.h scheduler.h /usr/include/assert.h ./object.h
cmu/imep/imep_io.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/imep/imep_io.o: ./cmu/debug.h /usr/include/string.h ./cmu/imep/imep.h
cmu/imep/imep_io.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/imep/imep_io.o: agent.h connector.h timer-handler.h drop-tail.h queue.h
cmu/imep/imep_io.o: ip.h trace.h ./cmu/rtproto/rtproto.h
cmu/imep/imep_io.o: ./cmu/imep/rxmit_queue.h ./cmu/imep/dest_queue.h
cmu/imep/imep_io.o: ./cmu/imep/imep_stats.h ./cmu/imep/imep_spec.h
cmu/imep/imep_util.o: ./cmu/imep/imep.h
cmu/imep/imep_util.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/imep/imep_util.o: /usr/include/sys/types.h /usr/include/features.h
cmu/imep/imep_util.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/imep/imep_util.o: /usr/include/bits/types.h
cmu/imep/imep_util.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/imep/imep_util.o: /usr/include/time.h /usr/include/endian.h
cmu/imep/imep_util.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/imep/imep_util.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/imep/imep_util.o: /usr/include/sys/sysmacros.h config.h
cmu/imep/imep_util.o: /usr/include/stdlib.h /usr/include/alloca.h agent.h
cmu/imep/imep_util.o: packet.h scheduler.h /usr/include/assert.h ./object.h
cmu/imep/imep_util.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/imep/imep_util.o: ./cmu/debug.h /usr/include/string.h connector.h
cmu/imep/imep_util.o: timer-handler.h drop-tail.h queue.h ip.h trace.h
cmu/imep/imep_util.o: ./cmu/rtproto/rtproto.h ./cmu/imep/rxmit_queue.h
cmu/imep/imep_util.o: ./cmu/imep/dest_queue.h ./cmu/imep/imep_stats.h
cmu/imep/imep_util.o: ./cmu/imep/imep_spec.h
cmu/imep/imep_timers.o: ./cmu/imep/imep.h
cmu/imep/imep_timers.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/imep/imep_timers.o: /usr/include/sys/types.h /usr/include/features.h
cmu/imep/imep_timers.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/imep/imep_timers.o: /usr/include/bits/types.h
cmu/imep/imep_timers.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/imep/imep_timers.o: /usr/include/time.h /usr/include/endian.h
cmu/imep/imep_timers.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/imep/imep_timers.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/imep/imep_timers.o: /usr/include/sys/sysmacros.h config.h
cmu/imep/imep_timers.o: /usr/include/stdlib.h /usr/include/alloca.h agent.h
cmu/imep/imep_timers.o: packet.h scheduler.h /usr/include/assert.h ./object.h
cmu/imep/imep_timers.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/imep/imep_timers.o: ./cmu/debug.h /usr/include/string.h connector.h
cmu/imep/imep_timers.o: timer-handler.h drop-tail.h queue.h ip.h trace.h
cmu/imep/imep_timers.o: ./cmu/rtproto/rtproto.h ./cmu/imep/rxmit_queue.h
cmu/imep/imep_timers.o: ./cmu/imep/dest_queue.h ./cmu/imep/imep_stats.h
cmu/imep/imep_timers.o: ./cmu/imep/imep_spec.h
cmu/imep/rxmit_queue.o: /usr/include/assert.h /usr/include/features.h
cmu/imep/rxmit_queue.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/imep/rxmit_queue.o: packet.h config.h /usr/include/stdlib.h
cmu/imep/rxmit_queue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/imep/rxmit_queue.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/imep/rxmit_queue.o: /usr/include/time.h /usr/include/endian.h
cmu/imep/rxmit_queue.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/imep/rxmit_queue.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/imep/rxmit_queue.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/imep/rxmit_queue.o: scheduler.h ./object.h ./cmu/list.h
cmu/imep/rxmit_queue.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/imep/rxmit_queue.o: /usr/include/string.h ./cmu/imep/rxmit_queue.h
cmu/imep/dest_queue.o: ./cmu/imep/dest_queue.h packet.h config.h
cmu/imep/dest_queue.o: /usr/include/stdlib.h /usr/include/features.h
cmu/imep/dest_queue.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/imep/dest_queue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/imep/dest_queue.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/imep/dest_queue.o: /usr/include/time.h /usr/include/endian.h
cmu/imep/dest_queue.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/imep/dest_queue.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/imep/dest_queue.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/imep/dest_queue.o: scheduler.h /usr/include/assert.h ./object.h
cmu/imep/dest_queue.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/imep/dest_queue.o: ./cmu/debug.h /usr/include/string.h ./cmu/imep/imep.h
cmu/imep/dest_queue.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/imep/dest_queue.o: agent.h connector.h timer-handler.h drop-tail.h
cmu/imep/dest_queue.o: queue.h ip.h trace.h ./cmu/rtproto/rtproto.h
cmu/imep/dest_queue.o: ./cmu/imep/rxmit_queue.h ./cmu/imep/imep_stats.h
cmu/imep/dest_queue.o: ./cmu/imep/imep_spec.h
cmu/dsr/path.o: /usr/include/assert.h /usr/include/features.h
cmu/dsr/path.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/dsr/path.o: /usr/include/stdio.h
cmu/dsr/path.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/dsr/path.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/dsr/path.o: /usr/include/bits/types.h /usr/include/libio.h
cmu/dsr/path.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
cmu/dsr/path.o: packet.h config.h /usr/include/stdlib.h
cmu/dsr/path.o: /usr/include/sys/types.h /usr/include/time.h
cmu/dsr/path.o: /usr/include/endian.h /usr/include/bits/endian.h
cmu/dsr/path.o: /usr/include/sys/select.h /usr/include/bits/select.h
cmu/dsr/path.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
cmu/dsr/path.o: /usr/include/alloca.h scheduler.h ./object.h ./cmu/list.h
cmu/dsr/path.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/dsr/path.o: /usr/include/string.h ip.h ./cmu/dsr/hdr_sr.h cmu/dsr/path.h
cmu/dsr/routecache.o: /usr/include/stdio.h /usr/include/features.h
cmu/dsr/routecache.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/dsr/routecache.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/dsr/routecache.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/dsr/routecache.o: /usr/include/bits/types.h /usr/include/libio.h
cmu/dsr/routecache.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
cmu/dsr/routecache.o: cmu/dsr/path.h /usr/include/assert.h packet.h config.h
cmu/dsr/routecache.o: /usr/include/stdlib.h /usr/include/sys/types.h
cmu/dsr/routecache.o: /usr/include/time.h /usr/include/endian.h
cmu/dsr/routecache.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/dsr/routecache.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/dsr/routecache.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/dsr/routecache.o: scheduler.h ./object.h ./cmu/list.h
cmu/dsr/routecache.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/dsr/routecache.o: /usr/include/string.h ./cmu/dsr/hdr_sr.h
cmu/dsr/routecache.o: cmu/dsr/routecache.h trace.h connector.h
cmu/dsr/routecache.o: ./cmu/dsr/cache_stats.h ./cmu/dsr/routecache.h
cmu/dsr/routecache.o: ./cmu/god.h ./cmu/node.h ./cmu/net-if.h ./cmu/channel.h
cmu/dsr/routecache.o: ./cmu/topography.h ./cmu/arp.h ./delay.h queue.h ip.h
cmu/dsr/requesttable.o: cmu/dsr/path.h /usr/include/stdio.h
cmu/dsr/requesttable.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/dsr/requesttable.o: /usr/include/gnu/stubs.h
cmu/dsr/requesttable.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/dsr/requesttable.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/dsr/requesttable.o: /usr/include/bits/types.h /usr/include/libio.h
cmu/dsr/requesttable.o: /usr/include/_G_config.h
cmu/dsr/requesttable.o: /usr/include/bits/stdio_lim.h /usr/include/assert.h
cmu/dsr/requesttable.o: packet.h config.h /usr/include/stdlib.h
cmu/dsr/requesttable.o: /usr/include/sys/types.h /usr/include/time.h
cmu/dsr/requesttable.o: /usr/include/endian.h /usr/include/bits/endian.h
cmu/dsr/requesttable.o: /usr/include/sys/select.h /usr/include/bits/select.h
cmu/dsr/requesttable.o: /usr/include/bits/sigset.h
cmu/dsr/requesttable.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/dsr/requesttable.o: scheduler.h ./object.h ./cmu/list.h
cmu/dsr/requesttable.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/dsr/requesttable.o: /usr/include/string.h ./cmu/dsr/hdr_sr.h
cmu/dsr/requesttable.o: cmu/dsr/constants.h cmu/dsr/requesttable.h
cmu/dsr/dsragent.o: /usr/include/assert.h /usr/include/features.h
cmu/dsr/dsragent.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/dsr/dsragent.o: /usr/include/math.h /usr/include/bits/huge_val.h
cmu/dsr/dsragent.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
cmu/dsr/dsragent.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/dsr/dsragent.o: /usr/include/stdio.h
cmu/dsr/dsragent.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/dsr/dsragent.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/dsr/dsragent.o: /usr/include/bits/types.h /usr/include/libio.h
cmu/dsr/dsragent.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
cmu/dsr/dsragent.o: /usr/include/signal.h /usr/include/bits/sigset.h
cmu/dsr/dsragent.o: /usr/include/bits/signum.h /usr/include/time.h
cmu/dsr/dsragent.o: /usr/include/bits/siginfo.h /usr/include/bits/sigaction.h
cmu/dsr/dsragent.o: /usr/include/bits/sigcontext.h
cmu/dsr/dsragent.o: /usr/include/asm/sigcontext.h
cmu/dsr/dsragent.o: /usr/include/bits/sigstack.h ./object.h scheduler.h
cmu/dsr/dsragent.o: agent.h config.h /usr/include/stdlib.h
cmu/dsr/dsragent.o: /usr/include/sys/types.h /usr/include/endian.h
cmu/dsr/dsragent.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/dsr/dsragent.o: /usr/include/bits/select.h /usr/include/sys/sysmacros.h
cmu/dsr/dsragent.o: /usr/include/alloca.h packet.h ./cmu/list.h
cmu/dsr/dsragent.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/dsr/dsragent.o: /usr/include/string.h connector.h timer-handler.h trace.h
cmu/dsr/dsragent.o: random.h rng.h ./cmu/mac.h ./cmu/ll.h ./delay.h queue.h
cmu/dsr/dsragent.o: ip.h ./cmu/arp.h ./cmu/node.h ./cmu/net-if.h
cmu/dsr/dsragent.o: ./cmu/channel.h ./cmu/topography.h ./cmu/god.h
cmu/dsr/dsragent.o: ./cmu/marshall.h ./cmu/cmu-trace.h ./cmu/god.h
cmu/dsr/dsragent.o: cmu/dsr/path.h ./cmu/dsr/hdr_sr.h cmu/dsr/srpacket.h
cmu/dsr/dsragent.o: cmu/dsr/routecache.h ./cmu/dsr/cache_stats.h
cmu/dsr/dsragent.o: ./cmu/dsr/routecache.h cmu/dsr/requesttable.h
cmu/dsr/dsragent.o: cmu/dsr/dsragent.h ./cmu/priqueue.h drop-tail.h
cmu/dsr/hdr_sr.o: /usr/include/stdio.h /usr/include/features.h
cmu/dsr/hdr_sr.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/dsr/hdr_sr.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/dsr/hdr_sr.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/dsr/hdr_sr.o: /usr/include/bits/types.h /usr/include/libio.h
cmu/dsr/hdr_sr.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
cmu/dsr/hdr_sr.o: ./cmu/dsr/hdr_sr.h /usr/include/assert.h packet.h config.h
cmu/dsr/hdr_sr.o: /usr/include/stdlib.h /usr/include/sys/types.h
cmu/dsr/hdr_sr.o: /usr/include/time.h /usr/include/endian.h
cmu/dsr/hdr_sr.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/dsr/hdr_sr.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/dsr/hdr_sr.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/dsr/hdr_sr.o: scheduler.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/dsr/hdr_sr.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h
cmu/dsr/mobicache.o: /usr/include/stdio.h /usr/include/features.h
cmu/dsr/mobicache.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/dsr/mobicache.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/dsr/mobicache.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/dsr/mobicache.o: /usr/include/bits/types.h /usr/include/libio.h
cmu/dsr/mobicache.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
cmu/dsr/mobicache.o: ./cmu/god.h cmu/dsr/path.h /usr/include/assert.h
cmu/dsr/mobicache.o: packet.h config.h /usr/include/stdlib.h
cmu/dsr/mobicache.o: /usr/include/sys/types.h /usr/include/time.h
cmu/dsr/mobicache.o: /usr/include/endian.h /usr/include/bits/endian.h
cmu/dsr/mobicache.o: /usr/include/sys/select.h /usr/include/bits/select.h
cmu/dsr/mobicache.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
cmu/dsr/mobicache.o: /usr/include/alloca.h scheduler.h ./object.h
cmu/dsr/mobicache.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/dsr/mobicache.o: ./cmu/debug.h /usr/include/string.h ./cmu/dsr/hdr_sr.h
cmu/dsr/mobicache.o: cmu/dsr/routecache.h trace.h connector.h
cmu/dsr/mobicache.o: ./cmu/dsr/cache_stats.h ./cmu/dsr/routecache.h
cmu/dsdv/rtable.o: /usr/include/string.h /usr/include/features.h
cmu/dsdv/rtable.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/dsdv/rtable.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/dsdv/rtable.o: /usr/include/stdlib.h /usr/include/sys/types.h
cmu/dsdv/rtable.o: /usr/include/bits/types.h /usr/include/time.h
cmu/dsdv/rtable.o: /usr/include/endian.h /usr/include/bits/endian.h
cmu/dsdv/rtable.o: /usr/include/sys/select.h /usr/include/bits/select.h
cmu/dsdv/rtable.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
cmu/dsdv/rtable.o: /usr/include/alloca.h /usr/include/stdio.h
cmu/dsdv/rtable.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/dsdv/rtable.o: /usr/include/libio.h /usr/include/_G_config.h
cmu/dsdv/rtable.o: /usr/include/bits/stdio_lim.h /usr/include/assert.h
cmu/dsdv/rtable.o: cmu/dsdv/rtable.h config.h scheduler.h queue.h connector.h
cmu/dsdv/rtable.o: ./object.h packet.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/dsdv/rtable.o: ./cmu/antenna.h ./cmu/debug.h ip.h
cmu/dsdv/dsdv.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/dsdv/dsdv.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/dsdv/dsdv.o: cmu/dsdv/dsdv.h agent.h config.h /usr/include/stdlib.h
cmu/dsdv/dsdv.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/dsdv/dsdv.o: /usr/include/gnu/stubs.h
cmu/dsdv/dsdv.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/dsdv/dsdv.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/dsdv/dsdv.o: /usr/include/time.h /usr/include/endian.h
cmu/dsdv/dsdv.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/dsdv/dsdv.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/dsdv/dsdv.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h packet.h
cmu/dsdv/dsdv.o: scheduler.h /usr/include/assert.h ./object.h ./cmu/list.h
cmu/dsdv/dsdv.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/dsdv/dsdv.o: /usr/include/string.h connector.h timer-handler.h ip.h
cmu/dsdv/dsdv.o: ./delay.h queue.h trace.h ./cmu/arp.h ./cmu/ll.h
cmu/dsdv/dsdv.o: ./cmu/node.h ./cmu/net-if.h ./cmu/channel.h
cmu/dsdv/dsdv.o: ./cmu/topography.h ./cmu/god.h ./cmu/mac.h ./cmu/marshall.h
cmu/dsdv/dsdv.o: ./cmu/priqueue.h drop-tail.h cmu/dsdv/rtable.h
cmu/dsdv/dsdv.o: cmu/priqueue.h random.h /usr/include/math.h
cmu/dsdv/dsdv.o: /usr/include/bits/huge_val.h /usr/include/bits/mathdef.h
cmu/dsdv/dsdv.o: /usr/include/bits/mathcalls.h rng.h ./cmu/cmu-trace.h
cmu/dsdv/dsdv.o: ./cmu/god.h
cmu/aodv/aodv.o: ./cmu/aodv/aodv.h /usr/include/sys/types.h
cmu/aodv/aodv.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/aodv/aodv.o: /usr/include/gnu/stubs.h /usr/include/bits/types.h
cmu/aodv/aodv.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/aodv/aodv.o: /usr/include/time.h /usr/include/endian.h
cmu/aodv/aodv.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/aodv/aodv.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/aodv/aodv.o: /usr/include/sys/sysmacros.h ./cmu/list.h agent.h config.h
cmu/aodv/aodv.o: /usr/include/stdlib.h /usr/include/alloca.h packet.h
cmu/aodv/aodv.o: scheduler.h /usr/include/assert.h ./object.h
cmu/aodv/aodv.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/aodv/aodv.o: /usr/include/string.h connector.h timer-handler.h
cmu/aodv/aodv.o: ./cmu/cmu-trace.h trace.h ./cmu/god.h ./cmu/priqueue.h
cmu/aodv/aodv.o: queue.h ip.h drop-tail.h ./cmu/rtqueue.h ./cmu/rttable.h
cmu/aodv/aodv.o: ./cmu/list.h ./cmu/aodv/aodv_packet.h random.h
cmu/aodv/aodv.o: /usr/include/math.h /usr/include/bits/huge_val.h
cmu/aodv/aodv.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
cmu/aodv/aodv.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/aodv/aodv.o: rng.h
cmu/aodv/aodv_logs.o: ./cmu/aodv/aodv.h /usr/include/sys/types.h
cmu/aodv/aodv_logs.o: /usr/include/features.h /usr/include/sys/cdefs.h
cmu/aodv/aodv_logs.o: /usr/include/gnu/stubs.h /usr/include/bits/types.h
cmu/aodv/aodv_logs.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/aodv/aodv_logs.o: /usr/include/time.h /usr/include/endian.h
cmu/aodv/aodv_logs.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/aodv/aodv_logs.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/aodv/aodv_logs.o: /usr/include/sys/sysmacros.h ./cmu/list.h agent.h
cmu/aodv/aodv_logs.o: config.h /usr/include/stdlib.h /usr/include/alloca.h
cmu/aodv/aodv_logs.o: packet.h scheduler.h /usr/include/assert.h ./object.h
cmu/aodv/aodv_logs.o: ./cmu/packet-stamp.h ./cmu/antenna.h ./cmu/debug.h
cmu/aodv/aodv_logs.o: /usr/include/string.h connector.h timer-handler.h
cmu/aodv/aodv_logs.o: ./cmu/cmu-trace.h trace.h ./cmu/god.h ./cmu/priqueue.h
cmu/aodv/aodv_logs.o: queue.h ip.h drop-tail.h ./cmu/rtqueue.h
cmu/aodv/aodv_logs.o: ./cmu/rttable.h ./cmu/list.h ./cmu/aodv/aodv_packet.h
cmu/cbrp/cbrpagent.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/cbrp/cbrpagent.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/cbrp/cbrpagent.o: cmu/cbrp/cbrpagent.h agent.h config.h
cmu/cbrp/cbrpagent.o: /usr/include/stdlib.h /usr/include/features.h
cmu/cbrp/cbrpagent.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/cbrp/cbrpagent.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/cbrp/cbrpagent.o: /usr/include/sys/types.h /usr/include/bits/types.h
cmu/cbrp/cbrpagent.o: /usr/include/time.h /usr/include/endian.h
cmu/cbrp/cbrpagent.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/cbrp/cbrpagent.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/cbrp/cbrpagent.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/cbrp/cbrpagent.o: packet.h scheduler.h /usr/include/assert.h ./object.h
cmu/cbrp/cbrpagent.o: ./cmu/list.h ./cmu/packet-stamp.h ./cmu/antenna.h
cmu/cbrp/cbrpagent.o: ./cmu/debug.h /usr/include/string.h connector.h
cmu/cbrp/cbrpagent.o: timer-handler.h ip.h ./delay.h queue.h trace.h
cmu/cbrp/cbrpagent.o: ./cmu/arp.h ./cmu/ll.h ./cmu/node.h ./cmu/net-if.h
cmu/cbrp/cbrpagent.o: ./cmu/channel.h ./cmu/topography.h ./cmu/god.h
cmu/cbrp/cbrpagent.o: ./cmu/mac.h ./cmu/marshall.h ./cmu/priqueue.h
cmu/cbrp/cbrpagent.o: drop-tail.h ./cmu/dsr/path.h /usr/include/stdio.h
cmu/cbrp/cbrpagent.o: /usr/include/libio.h /usr/include/_G_config.h
cmu/cbrp/cbrpagent.o: /usr/include/bits/stdio_lim.h ./cmu/dsr/hdr_sr.h
cmu/cbrp/cbrpagent.o: ./cmu/dsr/routecache.h ./cmu/dsr/requesttable.h
cmu/cbrp/cbrpagent.o: cmu/dsr/path.h cmu/cbrp/cbrp_packet.h
cmu/cbrp/cbrpagent.o: cmu/cbrp/hdr_cbrp.h cmu/cbrp/ntable.h cmu/priqueue.h
cmu/cbrp/cbrpagent.o: random.h /usr/include/math.h
cmu/cbrp/cbrpagent.o: /usr/include/bits/huge_val.h
cmu/cbrp/cbrpagent.o: /usr/include/bits/mathdef.h
cmu/cbrp/cbrpagent.o: /usr/include/bits/mathcalls.h rng.h ./cmu/cmu-trace.h
cmu/cbrp/cbrpagent.o: ./cmu/god.h ./cmu/mac-802_11.h ./cmu/mac-timers.h
cmu/cbrp/ntable.o: /usr/include/string.h /usr/include/features.h
cmu/cbrp/ntable.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/cbrp/ntable.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/cbrp/ntable.o: /usr/include/stdlib.h /usr/include/sys/types.h
cmu/cbrp/ntable.o: /usr/include/bits/types.h /usr/include/time.h
cmu/cbrp/ntable.o: /usr/include/endian.h /usr/include/bits/endian.h
cmu/cbrp/ntable.o: /usr/include/sys/select.h /usr/include/bits/select.h
cmu/cbrp/ntable.o: /usr/include/bits/sigset.h /usr/include/sys/sysmacros.h
cmu/cbrp/ntable.o: /usr/include/alloca.h /usr/include/stdio.h
cmu/cbrp/ntable.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/cbrp/ntable.o: /usr/include/libio.h /usr/include/_G_config.h
cmu/cbrp/ntable.o: /usr/include/bits/stdio_lim.h /usr/include/assert.h
cmu/cbrp/ntable.o: random.h /usr/include/math.h /usr/include/bits/huge_val.h
cmu/cbrp/ntable.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
cmu/cbrp/ntable.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/float.h
cmu/cbrp/ntable.o: config.h rng.h cmu/cbrp/cbrpagent.h agent.h packet.h
cmu/cbrp/ntable.o: scheduler.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/cbrp/ntable.o: ./cmu/antenna.h ./cmu/debug.h connector.h timer-handler.h
cmu/cbrp/ntable.o: ip.h ./delay.h queue.h trace.h ./cmu/arp.h ./cmu/ll.h
cmu/cbrp/ntable.o: ./cmu/node.h ./cmu/net-if.h ./cmu/channel.h
cmu/cbrp/ntable.o: ./cmu/topography.h ./cmu/god.h ./cmu/mac.h
cmu/cbrp/ntable.o: ./cmu/marshall.h ./cmu/priqueue.h drop-tail.h
cmu/cbrp/ntable.o: ./cmu/dsr/path.h ./cmu/dsr/hdr_sr.h ./cmu/dsr/routecache.h
cmu/cbrp/ntable.o: ./cmu/dsr/requesttable.h cmu/dsr/path.h
cmu/cbrp/ntable.o: cmu/cbrp/cbrp_packet.h cmu/cbrp/hdr_cbrp.h
cmu/cbrp/ntable.o: cmu/cbrp/ntable.h
cmu/cbrp/hdr_cbrp.o: /usr/include/stdio.h /usr/include/features.h
cmu/cbrp/hdr_cbrp.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
cmu/cbrp/hdr_cbrp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
cmu/cbrp/hdr_cbrp.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
cmu/cbrp/hdr_cbrp.o: /usr/include/bits/types.h /usr/include/libio.h
cmu/cbrp/hdr_cbrp.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
cmu/cbrp/hdr_cbrp.o: cmu/cbrp/hdr_cbrp.h /usr/include/assert.h packet.h
cmu/cbrp/hdr_cbrp.o: config.h /usr/include/stdlib.h /usr/include/sys/types.h
cmu/cbrp/hdr_cbrp.o: /usr/include/time.h /usr/include/endian.h
cmu/cbrp/hdr_cbrp.o: /usr/include/bits/endian.h /usr/include/sys/select.h
cmu/cbrp/hdr_cbrp.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
cmu/cbrp/hdr_cbrp.o: /usr/include/sys/sysmacros.h /usr/include/alloca.h
cmu/cbrp/hdr_cbrp.o: scheduler.h ./object.h ./cmu/list.h ./cmu/packet-stamp.h
cmu/cbrp/hdr_cbrp.o: ./cmu/antenna.h ./cmu/debug.h /usr/include/string.h
cmu/cbrp/hdr_cbrp.o: ./cmu/dsr/hdr_sr.h
tclAppInit.o: /usr/include/sys/types.h /usr/include/features.h
tclAppInit.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
tclAppInit.o: /usr/include/bits/types.h
tclAppInit.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tclAppInit.o: /usr/include/time.h /usr/include/endian.h
tclAppInit.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tclAppInit.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tclAppInit.o: /usr/include/sys/sysmacros.h /usr/include/sys/time.h
tclAppInit.o: /usr/include/bits/time.h /usr/include/sys/resource.h
tclAppInit.o: /usr/include/bits/resource.h
tkAppInit.o: /usr/include/tk.h /usr/include/tcl.h /usr/include/stdio.h
tkAppInit.o: /usr/include/features.h /usr/include/sys/cdefs.h
tkAppInit.o: /usr/include/gnu/stubs.h
tkAppInit.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h
tkAppInit.o: /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stdarg.h
tkAppInit.o: /usr/include/bits/types.h /usr/include/libio.h
tkAppInit.o: /usr/include/_G_config.h /usr/include/bits/stdio_lim.h
tkAppInit.o: /usr/include/X11/Xlib.h /usr/include/sys/types.h
tkAppInit.o: /usr/include/time.h /usr/include/endian.h
tkAppInit.o: /usr/include/bits/endian.h /usr/include/sys/select.h
tkAppInit.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
tkAppInit.o: /usr/include/sys/sysmacros.h /usr/include/X11/X.h
tkAppInit.o: /usr/include/X11/Xfuncproto.h /usr/include/X11/Xosdefs.h
tkAppInit.o: bitmap/play.xbm bitmap/stop.xbm bitmap/rewind.xbm bitmap/ff.xbm
