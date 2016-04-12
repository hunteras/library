#!/usr/bin/env perl
use strict;

use IO::Socket::INET;
use threads;

sub uploader {
    my ($name) = @_;
    # create a connecting socket
    my $socket = new IO::Socket::INET (
        PeerHost => '127.0.0.1',
        PeerPort => '7777',
        Proto => 'tcp',
        );
    die "cannot connect to the server $!\n" unless $socket;
    print "connected to the server\n";

    print "process file : $name \n"; 

    open(my $fh, "<", $name) or exit 1;
    binmode $fh;

    my $data="";
    while ((read($fh, $data, 8*1024)) != 0) {
        my $size = $socket->send($data);
        print "$name length : $size\n";
    }
    close $fh;
    print "done $name.\n";
    
    # notify server that request has been sent
    shutdown($socket, 1);

    $socket->close();

}

sub main {
    my @thrs = map { 
        print "pass file : $_\n";
        threads->create(\&uploader, $_);
    } @ARGV;

    map { $_->join(); } @thrs;
    print "exit.\n";
}

main;
