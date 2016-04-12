#!/usr/bin/env perl
use strict;

for (@ARGV) { 
    print "process file : $_ \n"; 

    open(my $fh, "<", $_) or die "cannot open file $_: $!";
    binmode $fh;

    my $data;
    while ((read($fh, $data, 1024)) != 0) {
        print length($data), "\n";
        print "$data";
    }
    close $fh;
}
