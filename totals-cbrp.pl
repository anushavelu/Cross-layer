#!/usr/bin/perl

#
# Structure of a "log" line.
#
$hdr->{opcode} = 0;
$hdr->{time} = 0;               # Not used by totals
$hdr->{node} = 0;
$hdr->{uid} = 0;                # Not used by totals
$hdr->{logtype} = 0;            # AGT, RTR, MAC
$hdr->{logreason} = 0;
$hdr->{pkttype} = 0;
$hdr->{pktsize} = 0;

my $log_error_fatal = 0;

@ARPTYPE = ("REQUEST", "REPLY");
@TCPTYPE = ("tcp", "ack");
@MACTYPE = ("RTS", "CTS", "ACK");
@TORATYPE = ("BEACON", "HELLO", "HELLO_ACK", "QUERY", "UPDATE", "CLEAR");
@DSRTYPE = ("REQUEST", "REPLY", "ERROR", "CACHED REPLY", "GRAT REPLY");
@AODVTYPE = ("REQUEST", "REPLY", "HELLO", "UNSOLICITED REPLY");
@IMEPTYPE = ("BEACON", "HELLO", "ACK", "OBJECT");
@CBRPTYPE = ("HELLO","REQUEST","REPLY","ERROR","GRAT REPLY(repaired)", "GRAT REPLY(shortened)", "GRAT REPLY(both)", "CACHED REPLY");                  #- added by Jinyang
$MACTYPE_RTS = hex("1b");
$MACTYPE_CTS = hex("1c");
$MACTYPE_ACK = hex("1d");
$MACTYPE_DATA = hex("20");

$infile = 0;			# input file
$time = 0;			# length of the simulation
$line = 0;			# line number of input file

$PACKET_SIZE = 1460;		# Data bytes in a TCP Packet
$MAX_ROUTE_LENGTH = 10;		# Maximum Route Length
$MAX_NODES = 0;			# Number of nodes
$TOTALS = 0;			# Number of nodes + 1;

#
# These are the *main* statistical categories that are used on
# a per-protocol basis.
#
$OP_TX = 1;             # transmit
$OP_RX = 2;             # receive
$OP_FW = 3;             # packet forwards
$OP_DR = 4;             # drops
$OP_ACT_RTLEN = 5;      # array of counts of actual route lengths
$OP_OPT_RTLEN = 6;      # array of counts of optimal route lengths
$OP_DIF_RTLEN = 7;      # array of counts of differences between OPT/ACT
$OP_OVERHEAD = 8;       # Per packet overhead (used by DSR)

#
# Global Subcategories
#
$BCNT = 1;              # byte count
$PCNT = 2;              # packet count
$GLOBAL_MAX = 2;

#
# Subcategories for TX
#
$TX_BCNT = $BCNT;        # Byte Count
$TX_PCNT = $PCNT;        # Packet Count

#
# Subcategories for RX
#
$RX_BCNT = $BCNT;        # Byte Count
$RX_PCNT = $PCNT;        # Packet Count

#
# Subcategories for FW
#
$FW_BCNT = $BCNT;        # Byte Count
$FW_PCNT = $PCNT;        # Packet Count

#
# Subcategories for packet drops at the MAC layer
#
$DR_MAC_COL = $GLOBAL_MAX + 1;          # collision
$DR_MAC_DUP = $GLOBAL_MAX + 2;          # duplicate
$DR_MAC_ERR = $GLOBAL_MAX + 3;          # CRC invalid
$DR_MAC_RET = $GLOBAL_MAX + 4;          # RETRY count exceeded
$DR_MAC_STA = $GLOBAL_MAX + 5;          # invalid state
$DR_MAC_BSY = $GLOBAL_MAX + 6;          # MAC busy

#
# Subcategories for packet drops a the RTR (Routing) layer
#
$DR_RTR_NRT = $GLOBAL_MAX + 1;          # No Route
$DR_RTR_TTL = $GLOBAL_MAX + 2;          # TTL Expired
$DR_RTR_IFQ = $GLOBAL_MAX + 3;          # Router Queue Full
$DR_RTR_TOUT = $GLOBAL_MAX + 4;         # Packet Timed Out in IFQ
$DR_RTR_LOOP = $GLOBAL_MAX + 5;         # Routing Loop
$DR_RTR_MAC_CALLBACK = $GLOBAL_MAX + 6; # Dropped by MAC Callback
$DR_IFQ_FULL = $GLOBAL_MAX + 7;         # Interface Queue Full
$DR_IFQ_ARP = $GLOBAL_MAX + 8;          # Dropped by ARP
$DR_END_SIM = $GLOBAL_MAX + 9;

# ======================================================================
# Initialization Routines
# ======================================================================
sub init_counters {
	my $A = shift(@_);

        $A->[$OP_TX]->[$BCNT] = 0;
        $A->[$OP_TX]->[$PCNT] = 0;

        $A->[$OP_RX]->[$BCNT] = 0;
        $A->[$OP_RX]->[$PCNT] = 0;

        $A->[$OP_FW]->[$BCNT] = 0;
        $A->[$OP_FW]->[$PCNT] = 0;

        $A->[$OP_DR]->[$BCNT] = 0;
        $A->[$OP_DR]->[$PCNT] = 0;

        $A->[$OP_DR]->[$DR_MAC_COL] = 0;
        $A->[$OP_DR]->[$DR_MAC_DUP] = 0;
        $A->[$OP_DR]->[$DR_MAC_ERR] = 0;
        $A->[$OP_DR]->[$DR_MAC_RET] = 0;
        $A->[$OP_DR]->[$DR_MAC_STA] = 0;
        $A->[$OP_DR]->[$DR_MAC_BSY] = 0;

        $A->[$OP_DR]->[$DR_RTR_NRT] = 0;
        $A->[$OP_DR]->[$DR_RTR_TTL] = 0;
        $A->[$OP_DR]->[$DR_RTR_IFQ] = 0;
        $A->[$OP_DR]->[$DR_RTR_TOUT] = 0;
        $A->[$OP_DR]->[$DR_RTR_LOOP] = 0;
	$A->[$OP_DR]->[$DR_RTR_MAC_CALLBACK] = 0;
	$A->[$OP_DR]->[$DR_IFQ_FULL] = 0;
	$A->[$OP_DR]->[$DR_IFQ_ARP] = 0;
	$A->[$OP_DR]->[$DR_END_SIM] = 0;
};

sub init_nodes {
        my $PKT = shift(@_);

        for($n = 1; $n <= $MAX_NODES; $n++) {
		init_counters($PKT->[$n]);
        }
}


sub init_type {

        my $PKT = shift(@_);

        if($PKT eq "CBR") {
                init_nodes(CBR);
        }
        if($PKT eq "DSR") {
	    $deadlink_seen = 0;
	    $reply_sent = 0;
	    $reply_received = 0;
	    $cache_reply_sent = 0;
	    $new_request = 0;
	    $grat_reply_sent = 0;
	    $pkts_salvaged = 0;
        }
      
        # Init CBRP counters
        if ($PKT eq "CBRP") {
            $cbrp_new_request = 0;
            $cbrp_request_broadcast = 0;
            $cbrp_reply_sent = 0;
            $cbrp_cache_reply_sent = 0;
            $cbrp_reply_received = 0;
            $cbrp_pkts_salvaged_localrepair = 0;
            $cbrp_pkts_salvaged_cache = 0;
            $cbrp_pkts_salvaged_request = 0;
            $cbrp_pkts_salvaged_reply = 0;
            $cbrp_pkts_dropped_request = 0;
            $cbrp_pkts_dropped_reply_looped = 0;
            $cbrp_pkts_dropped_reply_no_route = 0;
            $cbrp_pkts_success_route_shortened = 0;
            $cbrp_pkts_wrong_route_shortened = 0;
            $cbrp_pkts_grat_reply_repaired = 0;
            $cbrp_pkts_grat_reply_shortened = 0;
        }
            	

        #
        # Initialize each packet type for PKT.
        #
        foreach $P (@_) {

		init_counters($PKT->{$P});

                for($i = 0; $i <= $MAX_ROUTE_LENGTH; $i++) {
                        $PKT->{$P}->[$OP_ACT_RTLEN]->[$i] = 0;
                        $PKT->{$P}->[$OP_OPT_RTLEN]->[$i] = 0;
                        $PKT->{$P}->[$OP_DIF_RTLEN]->[$i] = 0;
                }
        }

        #
        #  Initialize TOTALS section of PKT
        #
	init_counters($PKT->[$TOTALS]);

        for($i = 0; $i <= $MAX_ROUTE_LENGTH; $i++) {
		$PKT->[$TOTALS]->[$OP_ACT_RTLEN]->[$i] = 0;
                $PKT->[$TOTALS]->[$OP_OPT_RTLEN]->[$i] = 0;
                $PKT->[$TOTALS]->[$OP_DIF_RTLEN]->[$i] = 0;
        }
}


# ======================================================================
# Output Routines
# ======================================================================
sub print_totals {

	my $A = shift(@_);
	my $B = shift(@_);
	my $C = shift(@_);

	printf("\t%s %s Transmitted\n", $B, $C);
	printf("\t\tPackets:        %d\n", $A->[$OP_TX]->[$PCNT]);
	printf("\t\tBytes:          %d\n", $A->[$OP_TX]->[$BCNT]);

	printf("\t%s %s Received\n", $B, $C);
	printf("\t\tPackets:        %d\n", $A->[$OP_RX]->[$PCNT]);
	printf("\t\tBytes:          %d\n", $A->[$OP_RX]->[$BCNT]);

        printf("\t%s %s Forwards\n", $B, $C);
        printf("\t\tPackets:        %d\n", $A->[$OP_FW]->[$PCNT]);
        printf("\t\tBytes:          %d\n", $A->[$OP_FW]->[$BCNT]);

        printf("\t%s %s Drops\n", $B, $C);
        printf("\t\tPackets:        %d\n", $A->[$OP_DR]->[$PCNT]);
        printf("\t\tBytes:          %d\n", $A->[$OP_DR]->[$BCNT]);

        if($SCRIPT_TYPE eq "RTR" || $SCRIPT_TYPE eq "TRP") {
                printf("\t\tNo Route:       %d\n",
                       $A->[$OP_DR]->[$DR_RTR_NRT]);
                printf("\t\tTTL Expired:    %d\n",
                       $A->[$OP_DR]->[$DR_RTR_TTL]);
                printf("\t\tRTR Queue Full: %d\n",
                       $A->[$OP_DR]->[$DR_RTR_IFQ]);
                printf("\t\tTimeout:        %d\n",
                       $A->[$OP_DR]->[$DR_RTR_TOUT]);
                printf("\t\tRouting Loop:   %d\n",
                       $A->[$OP_DR]->[$DR_RTR_LOOP]);
                printf("\t\tIFQ Full:       %d\n",
                       $A->[$OP_DR]->[$DR_IFQ_FULL]);
                printf("\t\tARP Full:       %d\n",
                       $A->[$OP_DR]->[$DR_IFQ_ARP]);  
                printf("\t\tMAC Callback:   %d\n",
                       $A->[$OP_DR]->[$DR_RTR_MAC_CALLBACK]);
		printf("\t\tSIM End:        %d\n",
		       $A->[$OP_DR]->[$DR_SIM_END]);
        }

        elsif($SCRIPT_TYPE eq "MAC") {
                printf("\t\tCollision:     %d\n",
                       $A->[$OP_DR]->[$DR_MAC_COL]);
                printf("\t\tDuplicate:     %d\n",
                       $A->[$OP_DR]->[$DR_MAC_DUP]);
                printf("\t\tCRC Invalid:   %d\n",
                       $A->[$OP_DR]->[$DR_MAC_ERR]);
                printf("\t\tMax Retries:   %d\n",
                       $A->[$OP_DR]->[$DR_MAC_RET]);
                printf("\t\tInvalid State: %d\n",
                       $A->[$OP_DR]->[$DR_MAC_STA]);
                printf("\t\tMAC Busy:      %d\n",
                       $A->[$OP_DR]->[$DR_MAC_BSY]);
        }

        elsif($SCRIPT_TYPE eq "AGT") {
        }

        else {
                print stderr "Invalid SCRIPT_TYPE: '$SCRIPT_TYPE'\n";
                if ($log_error_fatal) { exit 1; }
        }
        printf("\t%s %s Overhead\n", $B, $C);
        printf("\t\tPackets:       %d\n", $A->[$OP_OVERHEAD]->[$PCNT]);
        printf("\t\tBytes:         %d\n", $A->[$OP_OVERHEAD]->[$BCNT]);
}


sub show_totals {

	my $PKT = shift(@_);

	printf("\n%s Packets ========================================\n", $PKT);

	if($PKT eq "TOTAL") {
		print_totals($PKT, $PKT, "");
	}
	else {
		print_totals($PKT->[$TOTALS], $PKT, "TOTALS");
	}

	if ($PKT eq "DSR") {
	    printf("\t send buffer drops: %d\n",$snd_buf_drop);
	    printf("\t new route requests: %d\n",$new_request);
	    printf("\t replies sent by target: %d\n",$reply_sent);
	    printf("\t replies sent from cache: %d\n",$cache_reply_sent);
	    printf("\t replies received: %d\n",$reply_received);
	    printf("\t grat replies: %d\n",$grat_reply_sent);
	    printf("\t packets salvaged: %d\n",$pkts_salvaged);
	    printf("\t packets not salvaged: %d\n",$pkts_not_salvaged);
	    printf("\t bad replies not salvaged: %d\n",
		   $bad_reply_not_salvaged);
	    printf("\t IFQ len above 25: %d\n",$ifq_above_25);
	}

        if ($PKT eq "CBRP") {
	    printf("\t send buffer drops: %d\n",$snd_buf_drop);
	    printf("\t new route requests: %d\n",$cbrp_new_request);
	    printf("\t request broadcasted by clusterheads: %d\n",$cbrp_request_broadcast);
            printf("\t replies sent by target: %d\n",$cbrp_reply_sent);    
            printf("\t cache replies sent: %d\n",$cbrp_cache_reply_sent);    
            printf("\t replies received: %d\n", $cbrp_reply_received);
            printf("\t packets salvaged by localrepair: %d\n",$cbrp_pkts_salvaged_localrepair);
            printf("\t packets salvaged by cache: %d\n",$cbrp_pkts_salvaged_cache);
            printf("\t packets not salvaged: %d\n",$pkts_not_salvaged); 
            printf("\t route requests salvaged: %d\n", $cbrp_pkts_salvaged_request);
            printf("\t route requests dropped: %d\n",$cbrp_pkts_dropped_request);
            printf("\t route reply salvaged: %d\n", $cbrp_pkts_salvaged_reply);
            printf("\t route reply dropped(loop): %d\n",$cbrp_pkts_dropped_reply_looped);
            printf("\t route reply dropped(no-route): %d\n",$cbrp_pkts_dropped_reply_no_route);
            printf("\t routes successfully shortened: %d\n",$cbrp_pkts_success_route_shortened);
            printf("\t routes wrongly shortened: %d\n",$cbrp_pkts_wrong_route_shortened);       
            printf("\t gratuitous reply (repaired): %d\n",$cbrp_pkts_grat_reply_repaired);
            printf("\t gratuitous reply (shortened): %d\n",$cbrp_pkts_grat_reply_shortened);
            printf("\t IFQ len above 25: %d\n",$ifq_above_25);  
        }

	if(! @_) {
		return;
	}

	#
	# Individual Packet Formats
	#
	$tcnt = $PKT->[$TOTALS]->[$OP_TX]->[$PCNT];
	while(@_) {
		$P = shift(@_);

		$tcnt -= $PKT->{$P}->[$OP_TX]->[$PCNT];

		printf("\n\t%s %s Packets\n", $PKT, $P);

		print_totals($PKT->{$P}, $PKT, $P);
	}

	if($tcnt != 0) {
		print stderr "Error in sent totals.\n";
		# if ($log_error_fatal) { exit 1; }
	}
}

sub show_cbr_totals {

        show_totals(CBR);

        printf("\nDistributions:\n");    

        #
        # Optimal Route Length
        #
        my $sum = 0;
        printf("\tOptimal Path Len on sending\n");
        for($i = 1; $i <= $MAX_ROUTE_LENGTH; $i++) {
                printf("\t\t Optimal Len %2d: %d\n",
                       $i, CBR->[$TOTALS]->[$OP_OPT_RTLEN]->[$i]);
                $sum += CBR->[$TOTALS]->[$OP_OPT_RTLEN]->[$i];
        }
        printf("\t\t Optimal Len>%2d: %2d\n",
               $MAX_ROUTE_LENGTH,
               CBR->[$TOTALS]->[$OP_OPT_RTLEN]->[$MAX_ROUTE_LENGTH + 1]);
        $sum += CBR->[$TOTALS]->[$OP_OPT_RTLEN]->[$MAX_ROUTE_LENGTH + 1];
        printf("\t\t Optimal Len Sum: %2d\n", $sum);


        #
        # Actual Route Length
        #
        $sum = 0;
        printf("\tActual Path Len on receiving\n");
        for($i = 1; $i <= $MAX_ROUTE_LENGTH; $i++) {
                printf("\t\t Actual Len %2d: %d\n",
                       $i, CBR->[$TOTALS]->[$OP_ACT_RTLEN]->[$i]);
                $sum += CBR->[$TOTALS]->[$OP_ACT_RTLEN]->[$i];
        }
        printf("\t\t Actual Len>%2d: %d\n",
               $MAX_ROUTE_LENGTH, 
               CBR->[$TOTALS]->[$OP_ACT_RTLEN]->[$MAX_ROUTE_LENGTH + 1]);
        $sum += CBR->[$TOTALS]->[$OP_ACT_RTLEN]->[$MAX_ROUTE_LENGTH + 1];
        printf("\t\t Actual Len Sum:  %d\n", $sum);

        #
        # Difference between Actual and Optimal
        #
        $sum = 0;
        printf("\tActual - Optimal Path Len on receiving\n");
        for($i = 0; $i <= $MAX_ROUTE_LENGTH; $i++) {
                printf("\t\t Actual - Optimal Len %2d: %d\n",
                       $i, CBR->[$TOTALS]->[$OP_DIF_RTLEN]->[$i]);
                $sum += CBR->[$TOTALS]->[$OP_DIF_RTLEN]->[$i];
        }
        printf("\t\t Actual - Optimal Len>%2d: %d\n",
               $MAX_ROUTE_LENGTH,
               CBR->[$TOTALS]->[$OP_DIF_RTLEN]->[$MAX_ROUTE_LENGTH + 1]);
        $sum += CBR->[$TOTALS]->[$OP_DIF_RTLEN]->[$MAX_ROUTE_LENGTH + 1];
        printf("\t\t Actual - Optimal Len Sum: %d\n", $sum);

        #
        # Per Node Information...
        #
        if($SCRIPT_TYPE eq "MAC" || $SCRIPT_TYPE eq "RTR") {
                printf("\n");
                for($n = 1; $n <= $MAX_NODES; $n++) {
                        print_totals(CBR->[$n], CBR, "TOTALS $n");
                        printf("\n");
                }
        }
}


# ======================================================================
# ARP Packet Processing Routines
# ======================================================================
sub log_drop {
        my $A = shift(@_);
        my $LOGTYPE = shift(@_);
        my $REASON = shift(@_);

        if($LOGTYPE eq "MAC") {
                if($REASON eq "COL") {
                        $A->[$DR_MAC_COL] += 1;
                }
                elsif($REASON eq "DUP") {
                        $A->[$DR_MAC_DUP] += 1;
                }
                elsif($REASON eq "ERR") {
                        $A->[$DR_MAC_ERR] += 1;
                }
                elsif($REASON eq "RET") {
                        $A->[$DR_MAC_RET] += 1;
                }
                elsif($REASON eq "STA") {
                        $A->[$DR_MAC_STA] += 1;
                }
                elsif($REASON eq "BSY") {
                        $A->[$DR_MAC_BSY] += 1;
                }
                else {
                        print stderr "Invalid Drop Reason '$REASON'\n";
                        if ($log_error_fatal) { exit 1; }
                }
        }
        elsif($LOGTYPE eq "IFQ" && $SCRIPT_TYPE eq "RTR") {
                if($REASON eq "---") {
                        $A->[$DR_IFQ_FULL] += 1;
                }
                elsif($REASON eq "ARP") {
                        $A->[$DR_IFQ_ARP] += 1;
                }
		elsif($REASON eq "END") {
			$A->[$DR_SIM_END] += 1;
		}
                else {
                        print stderr "Invalid IFQ Drop Reason '$REASON'\n";
                        if ($log_error_fatal) { exit 1; }
                }
        }
        elsif($LOGTYPE eq "RTR" || $LOGTYPE eq "TRP") {
                if($REASON eq "NRTE") {
                        $A->[$DR_RTR_NRT] += 1;
                }
                elsif($REASON eq "TTL") {
                        $A->[$DR_RTR_TTL] += 1;
                }
                elsif($REASON eq "IFQ") {
                        $A->[$DR_RTR_IFQ] += 1;
                }
                elsif($REASON eq "TOUT") {
                        $A->[$DR_RTR_TOUT] += 1;
                }
                elsif($REASON eq "LOOP") {
                        $A->[$DR_RTR_LOOP] += 1;
                }
                elsif($REASON eq "CBK") {
                        $A->[$DR_RTR_MAC_CALLBACK] += 1;
                }
		elsif($REASON eq "END") {
			$A->[$DR_SIM_END] += 1;
		}
                else {
                        print stderr "Invalid RTR Drop Reason '$REASON'\n";
                        if ($log_error_fatal) { exit 1; }
                }
        }
        elsif($LOGTYPE eq "AGT") {
        }
        else {
                print stderr "Invalid Script Type\n";
                if ($log_error_fatal) { exit 1; }
        }
}


sub process_arp {
        my $hdr = shift(@_);
        my $LINE = shift(@_);              # line from log file

        my $OP = $hdr->{opcode};
        my $LOGTYPE = $hdr->{logtype};
        my $REASON = $hdr->{logreason};
        my $SIZE = $hdr->{pktsize};

	if($LINE =~ / ------- \[(\w+) (\d+)\/(\d+) (\d+)\/(\d+)\]/o) {
		$pkt = $1;

		if( $pkt != "REQUEST" && $pkt != "REPLY" ) {
			print stderr "Invalid ARP packet.\n";
			if ($log_error_fatal) { exit 1; }
		}
		ARP->{$pkt}->[$OP]->[$PCNT] += 1;
		ARP->{$pkt}->[$OP]->[$BCNT] += $SIZE;

                if($OP == $OP_DR) {
                        log_drop(ARP->{$pkt}->[$OP], $LOGTYPE, $REASON);
                }
	}
	else {
		print stderr "ARP Logging error\n$LINE\n";
		if ($log_error_fatal) { exit 1; }
	}

	ARP->[$TOTALS]->[$OP]->[$PCNT] += 1;
	ARP->[$TOTALS]->[$OP]->[$BCNT] += $SIZE;
}

# ======================================================================
# TORA Packet Processing Routines
# ======================================================================
sub process_tora {
        my $hdr = shift(@_);
        my $LINE = shift(@_);              # line from log file

        my $OP = $hdr->{opcode};
        my $LOGTYPE = $hdr->{logtype};
        my $REASON = $hdr->{logreason};
        my $SIZE = $hdr->{pktsize};

	if($LINE =~ / ------- \[\d+:\d+ \S+:\d+ \d+ \d+\].*\((\D+)\)/o) {
		$pkt = $1;

		TORA->{$pkt}->[$OP]->[$PCNT] += 1;
		TORA->{$pkt}->[$OP]->[$BCNT] += $SIZE;

                if($OP == $OP_DR) {
                        log_drop(TORA->{$pkt}->[$OP], $LOGTYPE, $REASON);
                }
	}
	else {
		print stderr "TORA Logging error\n$LINE\n";
		if ($log_error_fatal) { exit 1; }
	}

	TORA->[$TOTALS]->[$OP]->[$PCNT] += 1;
	TORA->[$TOTALS]->[$OP]->[$BCNT] += $SIZE;
}

# ======================================================================
# IMEP Packet Processing Routines
# ======================================================================
sub process_imep {
        my $hdr = shift(@_);
        my $LINE = shift(@_);              # line from log file

        my $OP = $hdr->{opcode};
        my $LOGTYPE = $hdr->{logtype};
        my $REASON = $hdr->{logreason};
        my $SIZE = $hdr->{pktsize};
#s 1.11 _11_ RTR  --- 24 IMEP 23 [0 0 0 0 0] ------- [11:255 -1:255 1 0] [- - - 0x0003] 

	if($LINE =~ / ------- \[\d+:\d+ \S+:\d+ \d+ \d+\] \[(.) (.) (.)/o) {
	    $ack = $1;
	    $hello = $2;
	    $object = $3;
	    
	    $pkt = "BEACON";

	    if ($ack ne '-') {
		$pkt = "ACK";
		IMEP->{$pkt}->[$OP]->[$PCNT] += 1;
	    }
	    if ($hello ne '-') {
		$pkt = "HELLO";
		IMEP->{$pkt}->[$OP]->[$PCNT] += 1;
	    }
	    if ($object ne '-') {
		$pkt = "OBJECT";
		IMEP->{$pkt}->[$OP]->[$PCNT] += 1;
	    }
	    if ($pkt eq "BEACON") {
		IMEP->{$pkt}->[$OP]->[$PCNT] += 1;
	    }

	    if($OP == $OP_DR) {
		log_drop(IMEP->{$pkt}->[$OP], $LOGTYPE, $REASON);
	    }
	}
	else {
		print stderr "IMEP Logging error\n$LINE\n";
		if ($log_error_fatal) { exit 1; }
	}

	IMEP->[$TOTALS]->[$OP]->[$PCNT] += 1;
	IMEP->[$TOTALS]->[$OP]->[$BCNT] += $SIZE;
}

# ======================================================================
# AODV Packet Processing Routines
# ======================================================================
sub process_aodv {
        my $hdr = shift(@_);
        my $LINE = shift(@_);              # line from log file

        my $OP = $hdr->{opcode};
        my $LOGTYPE = $hdr->{logtype};
        my $REASON = $hdr->{logreason};
        my $SIZE = $hdr->{pktsize};

	if($LINE =~ / ------- \[\d+:\d+ \S+:\d+ \d+ \d+\].*\((\D+)\)/o) {
		$pkt = $1;

		AODV->{$pkt}->[$OP]->[$PCNT] += 1;
		AODV->{$pkt}->[$OP]->[$BCNT] += $SIZE;

                if($OP == $OP_DR) {
                        log_drop(AODV->{$pkt}->[$OP], $LOGTYPE, $REASON);
                }
	}
	else {
		print stderr "AODV Logging error\n$LINE\n";
		if ($log_error_fatal) { exit 1; }
	}

	AODV->[$TOTALS]->[$OP]->[$PCNT] += 1;
	AODV->[$TOTALS]->[$OP]->[$BCNT] += $SIZE;
}
#======================================================================
# CBRP Packet Processing Routines
#=====================================================================
sub process_cbrp{
        my $hdr = shift(@_);
        my $LINE = shift(@_);              # line from log file

        my $OP = $hdr->{opcode};                                                        
        my $LOGTYPE = $hdr->{logtype};
        my $REASON = $hdr->{logreason};
        my $SIZE = $hdr->{pktsize};    

        if($LINE =~ / ------- \[(\d+):\d+ .*:\d+ \d+ \d+\] \[(\d+) #\d+ \d+->\d+\] \[(\d+) #\d+ \d+ \d+ (\d+)->.*\] \[(\d+) (\d+)] \[(\d+) \d+ \d+ \d+->\d+\]/o) {
                my $node = $hdr->{node};
                my $src_ipaddr = $1;

                my $pkt_req = $2;
                my $pkt_rep = $3;
                my $pkt_rep_src = $4;

                my $pkt_repaired = $5;
                my $pkt_shortened = $6;
                my $pkt_err = $7;

                if($pkt_req) {
                        $pkt = "REQUEST";
                }
                elsif($pkt_rep) {
                        if($pkt_repaired && $pkt_shortened) {
                                $pkt = "GRAT REPLY(both)";
                        }elsif($pkt_repaired) {
                                $pkt = "GRAT REPLY(repaired)";
                        }elsif($pkt_shortened) {
                                $pkt = "GRAT REPLY(shortened)";
                        }elsif($pkt_rep_src != $src_ipaddr) {
                                $pkt = "CACHED REPLY";
                        }
                        else {
                                $pkt = "REPLY";
                        }
                }
                elsif($pkt_err) {
                        $pkt = "ERROR";
                }
                else {
                        if($OP != $OP_DR) {
                                print stderr "Invalid CBRP Packet Type\n";
                                print stderr "$_";
                                if ($log_error_fatal) { exit 1; }
                        }
                }

                CBRP->{$pkt}->[$OP]->[$PCNT] += 1;
                CBRP->{$pkt}->[$OP]->[$BCNT] += $SIZE;

                if($OP == $OP_DR) {
                        log_drop(CBRP->{$pkt}->[$OP], $LOGTYPE, $REASON);
                }
        }
        else {
                print stderr "CBRP Logging error\n$LINE\n";
                if ($log_error_fatal) { exit 1; }
        }

        CBRP->[$TOTALS]->[$OP]->[$PCNT] += 1;
        CBRP->[$TOTALS]->[$OP]->[$BCNT] += $SIZE;
}        
       
# ======================================================================
# DSR Packet Processing Routines
# ======================================================================
sub process_dsr {
        my $hdr = shift(@_);
        my $LINE = shift(@_);              # line from log file

        my $OP = $hdr->{opcode};
        my $LOGTYPE = $hdr->{logtype};
        my $REASON = $hdr->{logreason};
        my $SIZE = $hdr->{pktsize};

	if($LINE =~ / ------- \[(\d+):\d+ \d+:\d+ \d+ \d+\] \d+ \[(\d+) \d+ \d+\] \[(\d+) (\d+) \d+ \d+->(\d+)\] \[(\d+) \d+ \d+ \d+->\d+\]/o) {
		my $node = $hdr->{node};
		my $src_ipaddr = $1;
#		my $src_port = $2;
#		my $dst_ipaddr = $3;
#		my $dst_port = $4;
		my $pkt_req = $2;
#		my $pkt_req_seqno = $6;
		my $pkt_rep = $3;
		my $pkt_rep_seqno = $4;
#		my $pkt_rep_len = $9;
#		my $pkt_rep_src = $10;
		my $pkt_rep_dst = $5;
		my $pkt_err = $6;
#		my $pkt_err_cnt = $13;
#		my $pkt_err_tell = $14;
#		my $pkt_error_src = $15;
#		my $pkt_error_dst = $16;

		if($pkt_req) {
			$pkt = "REQUEST";
		}
		elsif($pkt_rep) {
			if($pkt_rep_seqno == 0) {
				$pkt = "GRAT REPLY";
			}
			elsif($pkt_rep_dst != $src_ipaddr) {
				$pkt = "CACHED REPLY";
			}
			else {
				$pkt = "REPLY";
			}
		}
		elsif($pkt_err) {
			$pkt = "ERROR";
		}
		else {
			if($OP != $OP_DR) {
				print stderr "Invalid DSR Packet Type\n";
				print stderr "$_";
				if ($log_error_fatal) { exit 1; }
			}
		}

                DSR->{$pkt}->[$OP]->[$PCNT] += 1;
                DSR->{$pkt}->[$OP]->[$BCNT] += $SIZE;

                if($OP == $OP_DR) {
                        log_drop(DSR->{$pkt}->[$OP], $LOGTYPE, $REASON);
                }
	}
	else {
		print stderr "DSR Logging error\n$LINE\n";
		if ($log_error_fatal) { exit 1; }
	}

	DSR->[$TOTALS]->[$OP]->[$PCNT] += 1;
	DSR->[$TOTALS]->[$OP]->[$BCNT] += $SIZE;
}

# ======================================================================
# CBR Packet Processing Routines
# ======================================================================
sub process_cbr {
        my $hdr = shift(@_);
        my $LINE = shift(@_);              # line from log file

        my $OP = $hdr->{opcode};
        my $LOGTYPE = $hdr->{logtype};
        my $REASON = $hdr->{logreason};
        my $SIZE = $hdr->{pktsize};

	if($LINE =~ / ------- \[(\d+):(\d+) (\d+):(\d+) \d+ \d+\] \[\d+\] (\d+) (\d+)/o) {
                my $node = $hdr->{node};
                my $src_ipaddr = $1;
                my $src_ipport = $2;
                my $dst_ipaddr = $3;
                my $dst_ipport = $4;
                my $act_rt_len = $5;       # actual length
                my $opt_rt_len = $6;       # optimal length

                #
                # Count per-packet DSR Overhead bytes.
                # This is a temporary "hack" that needs to be fixed after
                # CMUTrace is modified - Josh, 98APR11
                #
                # After this gets changed:note that if you piggyback a 
                # data packet on a route request and broadcast the
                # packet, the source route bytes will be free as the
                # packet propagates out.
                #
                if($SCRIPT_TYPE eq "AGT") {
                        if($OP == $OP_RX && $node == $dst_ipaddr) {
                                CBR->[$TOTALS]->[$OP_OVERHEAD]->[$PCNT] += 1;
                                CBR->[$TOTALS]->[$OP_OVERHEAD]->[$BCNT] +=
                                  ((4 * $act_rt_len + 4) * $act_rt_len);

                                CBR->[$node]->[$OP_OVERHEAD]->[$PCNT] += 1;
                                CBR->[$node]->[$OP_OVERHEAD]->[$BCNT] +=
                                  ((4 * $act_rt_len + 4) * $act_rt_len);
                        }
                }

                ############################################################

                if($OP == $OP_DR) {
                        log_drop(CBR->[$TOTALS]->[$OP], $LOGTYPE, $REASON);
                        log_drop(CBR->[$node]->[$OP], $LOGTYPE, $REASON);
                }

                CBR->[$TOTALS]->[$OP]->[$PCNT] += 1;
                CBR->[$TOTALS]->[$OP]->[$BCNT] += $SIZE;

                #
                # Per node information...
                #
                CBR->[$node]->[$OP]->[$PCNT] += 1;
                CBR->[$node]->[$OP]->[$BCNT] += $SIZE;

                #
                # The GOD information is only meaningful in a MAC script.
                #
                if($SCRIPT_TYPE ne "AGT") {
                        return;
                }

                #
                # The distribution of OPTIMAL route lengths is collected at the sender.
                #
                if($OP == $OP_TX && $node == $src_ipaddr) {
                        if($act_rt_len != 0) {
                                print stderr "Error in GOD information\n$LINE\n";
                                # if ($log_error_fatal) { exit 1; }
                        }

                        if($opt_rt_len > $MAX_ROUTE_LENGTH) {
                                $opt_rt_len = $MAX_ROUTE_LENGTH + 1;
                        }

                        CBR->[$TOTALS]->[$OP_OPT_RTLEN]->[$opt_rt_len] += 1;
                }
                #
                # The distribution of ACTUAL route lengths is collected at the receiver.
                #
                elsif($OP == $OP_RX && $node == $dst_ipaddr) {
                        if($act_rt_len <= 0) {
                                print stderr "Error in GOD information\n$LINE\n";
                                if ($log_error_fatal) { exit 1; }
                        }

                        $len = $act_rt_len - $opt_rt_len;
             
                        #
                        # Bound the difference between ACTUAL and OPTIMAL
                        #
                        if($len < 0) {
                                print stderr "$LINE";
                                print stderr "Actual RT Length < Optimal.\n";
                                $len = 0;
                        }
                        elsif($len > $MAX_ROUTE_LENGTH) {
                                print "$LINE";
                                print "Actual RT Length > Optimal + $MAX_ROUTE_LENGTH.\n";
                                $len = $MAX_ROUTE_LENGTH + 1;
                        }

                        #
                        # Bound the ACTUAL route length.
                        #
                        if($act_rt_len > $MAX_ROUTE_LENGTH) {
                                $act_rt_len = $MAX_ROUTE_LENGTH + 1;
                        }
                        CBR->[$TOTALS]->[$OP_ACT_RTLEN]->[$act_rt_len] += 1;
                        CBR->[$TOTALS]->[$OP_DIF_RTLEN]->[$len] += 1;
                }
        }
        else {
                print stderr "CBR Logging error\n$LINE\n";
                if ($log_error_fatal) { exit 1; }
        }
}


# ======================================================================
# MAC Packet Processing Routines
# ======================================================================
sub process_msg {
        my $hdr = shift(@_);
        my $LINE = shift(@_);              # line from log file

        my $OP = $hdr->{opcode};
        my $LOGTYPE = $hdr->{logtype};
        my $REASON = $hdr->{logreason};
        my $SIZE = $hdr->{pktsize};

        if($OP == $OP_DR) {
                log_drop(MSG->[$TOTALS]->[$OP], $LOGTYPE, $REASON);
        }

        MSG->[$TOTALS]->[$OP]->[$PCNT] += 1;
        MSG->[$TOTALS]->[$OP]->[$BCNT] += $SIZE;
}

# ======================================================================
# MAC Packet Processing Routines
# ======================================================================
sub process_mac {
        my $hdr = shift(@_);
        my $LINE = shift(@_);              # line from log file

        my $OP = $hdr->{opcode};
        my $LOGTYPE = $hdr->{logtype};
        my $REASON = $hdr->{logreason};
        my $SIZE = $hdr->{pktsize};

	if($LINE =~ /\[(\w+) (\w+) (\w+) (\w+) (\w+)\]/o) {
		$t = hex($1) & 255;

		if($t == $MACTYPE_RTS) {
			$pkt = "RTS";
		}
		elsif($t == $MACTYPE_CTS) {
			$pkt = "CTS";
		}
		elsif($t == $MACTYPE_ACK) {
			$pkt = "ACK";
		}
		else {
			print stderr "Invalid MAC packet.\n";
			if ($log_error_fatal) { exit 1; }
		}

		MAC->{$pkt}->[$OP]->[$PCNT] += 1;
		MAC->{$pkt}->[$OP]->[$BCNT] += $SIZE;

		if($OP == $OP_DR) {
			log_drop(MAC->{$pkt}->[$OP], $LOGTYPE, $REASON);
		}

	}
	else {
		print stderr "MAC Logging error\n$LINE\n";
		if ($log_error_fatal) { exit 1; }
	}

	MAC->[$TOTALS]->[$OP]->[$PCNT] += 1;
	MAC->[$TOTALS]->[$OP]->[$BCNT] += $SIZE;
}

# ======================================================================
# Imep stats
# ======================================================================
sub process_imep_stats {
    my $LINE = shift(@_);
    
    if ($LINE =~ /IL \d+\.\d+ _(\d+)_ (.*)/) {
	print "$1:  $2\n";
    }


    if ($LINE =~ /Add-Adj: (\d+) New-Neigh: (\d+) Del-Neigh1: (\d+) Del-Neigh2: (\d+) Del-Neigh3: (\d+)/o) {
	$Add_Adj += $1;
	$New_Neigh +=  $2;
	$Del_Neigh1 +=  $3;
	$Del_Neigh2 +=  $4;
	$Del_Neigh3 +=  $5;
    } elsif ($LINE =~ /Created QRY: (\d+) UPD: (\d+) CLR: (\d+)/o) {
	$CQRY +=  $1;
	$CUPD +=  $2;
	$CCLR +=  $3;
    } elsif ($LINE =~ /Received QRY: (\d+) UPD: (\d+) CLR: (\d+)/o) {
	$RQRY +=  $1;
	$RUPD +=  $2;
	$RCLR +=  $3;
    } elsif ($LINE =~ /Total-Obj-Created: (\d+) Obj-Pkt-Created: (\d+) Obj-Pkt-Recvd: (\d+)/o) {
	$Total_Obj_Created += $1;
	$Obj_Pkt_Created +=  $2;
	$Obj_Pkt_Recvd +=  $3;
    } elsif ($LINE =~ /Rexmit Pkts: (\d+) Acked: (\d+) Retired: (\d+) Rexmits: (\d+)/o) {
	$RPkts += $1;
	$RAcked +=  $2;
	$RRetired +=  $3;
	$RRexmits +=  $4;
    } elsif ($LINE =~ /Sum-Response-List-Size Created: (\d+) Retired: (\d+)/o) {
	$SRLCreated +=  $1;
	$SRLRetired +=  $2;
    } elsif ($LINE =~ /Holes Created: (\d+) Retired: (\d+) ReSeqQ-Drops: (\d+) ReSeqQ-Recvd: (\d+)/o) { 
	$HCreated += $1;
	$HRetired += $2;
	$HReSeqQ_Drops += $3;
	$HReSeqQ_Recvd += $4;
    } elsif ($LINE =~ /Unexpected-Acks: (\d+) Out-Win-Obj: (\d+) Out-Order-Obj: (\d+) In-Order-Obj: (\d+)/o) {
	$Unexpected_Acks +=  $1;
	$Out_Win_Obj +=  $2;
	$Out_Order_Obj +=  $3;
	$In_Order_Obj +=  $4;
    }
};

sub dump_imep_stats {

    print "\nIMEP STATS ========================================\n";

    print "TOTALS:\n";
    print " Add_Adj:  $Add_Adj  New_Neigh:  $New_Neigh  Del_Neigh1: $Del_Neigh1  Del_Neigh2: $Del_Neigh2  Del_Neigh3: $Del_Neigh3\n";
    print " Created QRY:  $CQRY  UPD:  $CUPD  CLR:  $CCLR  \n";
    print " Received QRY:  $RQRY  UPD:  $RUPD  CLR:  $RCLR  \n";
    print " Total_Obj_Created:  $Total_Obj_Created  Obj_Pkt_Created:  $Obj_Pkt_Created  Obj_Pkt_Recvd:  $Obj_Pkt_Recvd  \n";
    print " Rexmit Pkts:  $RPkts  Acked:  $RAcked  Retired:  $RRetired  Rexmits:  $RRexmits  \n";
    print " Sum_Response_List_Size Created:  $SRLCreated  Retired:  $SRLRetired  \n";
    print " Holes Created:  $HCreated  Retired:  $HRetired  ReSeqQ_Drops:  $HReSeqQ_Drops  HReSeqQ_Recvd:  $HReSeqQ_Recvd  \n";
    print " Unexpected_Acks:  $Unexpected_Acks  Out_Win_Obj:  $Out_Win_Obj  Out_Order_Obj:  $Out_Order_Obj  In_Order_Obj:  $In_Order_Obj  \n";

    print  "\nSTATS\n";
    printf("  Ave Response List Len  Created:  %f   Retired: %f\n",
	   $RPkts ? $SRLCreated / $RPkts : -1.0, 
	   $RRetired ? $SRLRetired / $RRetired : -1.0);
    printf("  Ave Rexmits/Pkt %f \n",
	   $RPkts ? $RRexmits / $RPkts : -1.0);
    printf("  In order Objs %f\% \n",
	   $Obj_Pkt_Recvd ? 100.0 * $In_Order_Obj / $Obj_Pkt_Recvd : -1.0);
};

# ======================================================================
# Main Procedure
# ======================================================================
if($#ARGV != 2) {
	print stderr "\nusage: $0 <input file> <script type> <num nodes>\n\n";
	exit 1;
}

if(! open $infile, $ARGV[0]) {
	print stderr "Could not open $ARGV[0]\n";
	exit 1;
}

$SCRIPT_TYPE = $ARGV[1];
$MAX_NODES = $ARGV[2];
$TOTALS = $MAX_NODES + 1;

#
# Initialize Data Structures
#
init_type(MAC, @MACTYPE);
init_type(CBR);
init_type(ARP, @ARPTYPE);
init_type(DSR, @DSRTYPE);
init_type(TORA, @TORATYPE);
init_type(IMEP, @IMEPTYPE);
init_type(AODV, @AODVTYPE);

while(<$infile>) {

	$line += 1;

	if(/^[rsfD] (\d+).\d+ _(\d+)_ (\S+)\s+(\S+) \d+ (\S+) (\d+) \[\w+ \w+ \w+ \w+ \w+\]/o) {
                $time = $1;
                $hdr->{node} = $2;
                $hdr->{logtype} = $3;           # AGT, RTR, MAC
                $hdr->{logreason} = $4;
		$hdr->{pkttype} = $5;
		$hdr->{pktsize} = $6;

                if($SCRIPT_TYPE eq "RTR") {
                        if($hdr->{logtype} ne "RTR" &&
                           $hdr->{logtype} ne "IFQ") {
                                next;
                        }
                }
                elsif($SCRIPT_TYPE ne $hdr->{logtype}) {
                        next;
                }

                # ============================================================
                # Set the OPCODE for this line of input
                # ============================================================
		if(/^s /) {
                        $hdr->{opcode} = $OP_TX;
                }
                elsif(/^f /) {
			$hdr->{opcode} = $OP_FW;
		}
		elsif(/^r /) {
			$hdr->{opcode} = $OP_RX;
		}
		elsif(/^D /) {
                        $hdr->{opcode} = $OP_DR;
                }
		else {
			print stderr "Invalid OPERATION\n$_\n";
			if ($log_error_fatal) { exit 1; }
		}

                if($hdr->{pkttype} eq "MAC") {
                        process_mac($hdr, $_);
                }
		elsif($hdr->{pkttype} eq "ARP") {
                      	process_arp($hdr, $_);
                }
#                elsif($hdr->{pkttype} eq "tcp" || $hdr->{pkttype} eq "ack") {
#                        process_tcp($opcode, $pktsize, $_);
#                }
                elsif($hdr->{pkttype} eq "TORA") {
                        process_tora($hdr, $_);
                }
                elsif($hdr->{pkttype} eq "IMEP") {
                        process_imep($hdr, $_);
                }
                elsif($hdr->{pkttype} eq "AODV") {
                        process_aodv($hdr, $_);
                }
                elsif($hdr->{pkttype} eq "cbr") {
                        process_cbr($hdr, $_);
                }
                elsif($hdr->{pkttype} eq "DSR") {
                        process_dsr($hdr, $_);
                }
                elsif($hdr->{pkttype} eq "CBRP") {
                        process_cbrp($hdr,$_);
                }
                elsif($hdr->{pkttype} eq "message") {
                        process_msg($hdr, $_);
                }	
                else {
                        print stderr "Invalid packet type $hdr->{pkttype}\n";
                        if ($log_error_fatal) { exit 1; }
                }
	}
	#
	# Mobility Logging
	#
	elsif(/^M/o) {
	}
	#
	# AODV Logging
	#
	elsif(/^A/o) {
	}
	#
	# TORA Logging
	#
	elsif(/^T/o) {
	}
	#
	# DSR Logging
	#
	elsif(/^SRR \d+.\d+ _\d+_ ([\w-]+)/o) {
	    if ($1 eq "reply-sent") {
		$reply_sent++;
	    } elsif ($1 eq "reply-received") {
		$reply_received++;
	    } elsif ($1 eq "cache-reply-sent") {
		$cache_reply_sent++;
	    } elsif ($1 eq "new-request") {
		$new_request++;
	    } elsif ($1 eq "gratuitous-reply-sent") {
		$grat_reply_sent++;
	    } elsif ($1 eq "---") {
		$bad_reply_not_salvaged++;
	    }
	} elsif(/^Ssb/o) {
	    $snd_buf_drop++;
	} elsif (/^Ssalv .* salvaging/o) {
	    $pkts_salvaged++;
	} elsif (/^Ssalv .* dropping/o) {
	    $pkts_not_salvaged++;
	} elsif (/^SIFQ .*len \d+$/o) {
	    $ifq_above_25++;
	} elsif (/^S/o) {
	}
        #
        #CBRP Logging
        #
        elsif(/^CBRP \d+.\d+ _\d+_ ([\w-]+)/o) {
            if ($1 eq "new-request") {
                $cbrp_new_request++;
            }elsif ($1 eq "broadcast-request") {
                $cbrp_request_broadcast++;
            }elsif ($1 eq "reply-sent") {
                $cbrp_reply_sent++;
            }elsif ($1 eq "reply-received") {
                $cbrp_reply_received++;
            }elsif ($1 eq "cache-reply-sent") {
                $cbrp_cache_reply_sent++;
            }elsif ($1 eq "salvage-repair") {
                $cbrp_pkts_salvaged_localrepair++;
            }elsif ($1 eq "salvage-cache") {
                $cbrp_pkts_salvaged_cache++;
            }elsif ($1 eq "salvage-request") {
                $cbrp_pkts_salvaged_request++;
            }elsif ($1 eq "drop-request") {
                $cbrp_pkts_dropped_request++;
            }elsif ($1 eq "drop-reply-looped") {
                $cbrp_pkts_dropped_reply_looped++;
            }elsif ($1 eq "drop-reply-no-route") {
                $cbrp_pkts_dropped_reply_no_route++;
            }elsif ($1 eq "salvage-reply") {
                $cbrp_pkts_salvaged_reply++;
            }elsif ($1 eq "success-shorten") {
                $cbrp_pkts_success_route_shortened++;
            }elsif ($1 eq "wrong-shorten") {
                $cbrp_pkts_wrong_route_shortened++;  
            }elsif ($1 eq "grat-reply-repair") {
                $cbrp_pkts_grat_reply_repaired++;
            }elsif ($1 eq "grat-reply-shorten") {
                $cbrp_pkts_grat_reply_shortened++;
            }
        }elsif(/^cbrp/o) {

        }
	# 
	# DSDV Logging
	#
	elsif(/^V/o) {
	}
	#
	# GOD Logging
	#
	elsif(/^G/o) {
	}
	elsif(/^IL/o) {
	    process_imep_stats($_);
	}
	else {
		print stderr "Error, $line: '$_'\n";
#		if ($log_error_fatal) { exit 1; }
	}
}

$time += 1;		# accounts for fractional part

dump_imep_stats();
show_totals(MAC, @MACTYPE);
show_totals(ARP, @ARPTYPE);
show_totals(DSR, @DSRTYPE);
show_totals(MSG, @MSGTYPE);
show_totals(TORA, @TORATYPE);
show_totals(IMEP, @IMEPTYPE);
show_totals(AODV, @AODVTYPE);
show_totals(CBRP,@CBRPTYPE);
show_cbr_totals();

printf("\nSimulation Time: %d\n", $time);

