#!/usr/bin/env perl

use warnings;
use strict;
use Getopt::Long;
use Log::Log4perl qw(:easy);
Getopt::Long::Configure("prefix_pattern=\\-");
my $log = get_logger();

$|=1; # Unbuffered STDOUT


our $is_debug = $ENV{log4batch_debug};


GetOptions(
    'date'        => \my $date,
    'help|?'      => \my $help,
);

my $LEVEL = $ARGV[0];
my $pars = @ARGV;

if ( defined $help ) { usage(); exit(1) }

if ( ! defined $LEVEL ) {
    $LEVEL = "INFO";
} else {
    $LEVEL = uc $LEVEL;
}

if ( $LEVEL =~ m/DEBUG|WARN|ERROR|FATAL/i ) {
    shift(@ARGV);
    else_init();
    give_back();
} elsif ( $LEVEL =~ m/INFO/i ) {
    shift(@ARGV);
    info_init();
    give_back();
} else {
    # wenns jemand vergisst, dann einfach INFO daraus machen =)
    $LEVEL = "INFO";
    info_init();
    give_back();
}


################################################################################

sub give_back {
    $LEVEL= lc $LEVEL;
    if ( ! defined $is_debug && $LEVEL eq "debug") {
        #$log->$LEVEL("@ARGV");
    } else {
        $log->$LEVEL("@ARGV");
    }
}

sub info_init {
    if ( defined $date ) {
        Log::Log4perl->easy_init(
        {
            level => $DEBUG,
            file => 'stdout',
            mode => "append",
            #layout => "%-7p %d> %m%n",
            layout => "%-7p %d{yyyy-MM-dd HH:mm:ss}# %m%n",
        }
        );
    } else {
        Log::Log4perl->easy_init(
        {
            level => $DEBUG,
            file => 'stdout',
            mode => "append",
            layout => "%-7p %d{yyyy-MM-dd HH:mm:ss}# %m%n",
            #layout => "%-7p> %m%n",
        }
        );
    }
}

sub else_init {
    if ( defined $date ) {
        Log::Log4perl->easy_init(
        {
        level => $DEBUG,
        file => 'stdout',
        mode => "append",
        #layout => "%-7p %d> %m%n",
        layout => "%-7p %d{yyyy-MM-dd HH:mm:ss}# %m%n",
        }
        );
    } else {
        Log::Log4perl->easy_init(
        {
        level => $DEBUG,
        file => 'stdout',
        mode => "append",
        #layout => "%-7p> %m%n",
        layout => "%-7p %d{yyyy-MM-dd HH:mm:ss}# %m%n",
        }
        );
    }
}

sub usage {
    print "
    Usage: \n
    $0 [-d] DEBUG|INFO|WARN|ERROR|FATAL Text to print and log.\n
    Option -d: prints message with date and time.\n
    Only if \'log4batch_debug\' is set/exported,
    debug-messages will be printed, too.\n";
}
