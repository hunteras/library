#!/usr/bin/env perl
package Proto;
use Moose;


has 'type', is => 'ro', isa => 'Str';
has 'filename', is => 'rw', isa => 'Str';

sub msg {
    print "msg: @_ \n";
}

1;
