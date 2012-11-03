#!/usr/bin/perl

################################################################################
# File:       mkpub.pl
# Author:     Noah 
# Usage:      mkpub.pl [args]
#             makes public all files in directory
################################################################################

use strict;
use warnings;
use File::Find; 
use Cwd;
use Fcntl ':mode';

my $directory = Cwd::getcwd();

find(\&mkpriv, $directory);

sub mkpriv{ 

	next if ( ($File::Find::name eq ".") || ($File::Find::name eq "..") );
   
   	if (-x $File::Find::name ){
   		chmod 0755, $File::Find::name or die "Couldn't chmod $File::Find::name: $!"; 
   	}
}
