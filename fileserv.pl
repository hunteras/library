#!/usr/bin/env perl
use strict;

use threads;
use IO::Socket::INET;

my $datadir = '/Users/zhouyan/Data/repo';

sub receiver {
    my ($client_socket) = @_;
    # get information about a newly connected client
    my $client_address = $client_socket->peerhost();
    my $client_port = $client_socket->peerport();
    print "connection from $client_address:$client_port\n";
    
    # read up to 1024 characters from the connected client
    my $data = "";
    while(1) {
        my $size = read($client_socket, $data, 8*1024);
        last if $size == 0 || $size == undef ;
        print "received data: $size \n";
    }
    close $client_socket;

    print "client $client_address:$client_port disconnect.\n";    
}

sub main {
    # creating a listening socket
    my $socket = new IO::Socket::INET (
        LocalHost => '0.0.0.0',
        LocalPort => '7777',
        Proto => 'tcp',
        Listen => 5,
        ReuseAddr => 1
        );
    die "cannot create socket $!\n" unless $socket;
    print "server waiting for client connection on port 7777\n";

    while(1)
    {
        # waiting for a new client connection
        my $client_socket = $socket->accept();
        
        
        my $thr = threads->create(\&receiver, $client_socket);
        $thr->detach();
    }

    $socket->close();
}


main;
