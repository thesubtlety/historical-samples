#!/usr/bin/perl

################################################################################
# File:       mkrpiv.pl
# Author:     Noah 
# Usage:      mkpriv.pl [args]
#             makes private all files in directory
################################################################################

use strict;
use warnings;
use File::Find; 
use Cwd;
use Fcntl ':mode';

my $directory = Cwd::getcwd();

find(\&mkpriv, $directory);

sub mkpriv{ 

	my $permissions = sprintf "%04o", S_IMODE(my $mode);
   
  	if ($permissions != 0700) { 
      chmod 0700, $File::Find::name or die "Couldn't chmod $File::Find::name: $!"; 
      }
   
  	next if ( ($File::Find::name eq ".") || ($File::Find::name eq "..") );
    
	}
