#!/usr/bin/env perl
use strict;
use Net::FTP;

my $ftpserv = "192.168.0.99";

my $ftp = Net::FTP->new($ftpserv, Debug => 0)
    or die "Cannot connect to $ftpserv: $@";

$ftp->login("zy",'daf030987')
    or die "Cannot login ", $ftp->message;

$ftp->cwd("/Codes")
    or die "Cannot change working directory ", $ftp->message;

print $ftp->pwd(), "\n";

# $ftp->get("filespeed")
#     or die "get failed ", $ftp->message;

$ftp->quit;
