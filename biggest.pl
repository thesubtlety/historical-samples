#!/usr/bin/perl

################################################################################
# File:       biggest.pl
# Author:     Noah Potti
# Usage:      biggest.pl [args]
#               Lists all largest file in either current working directory or a 
#		specified directory.
################################################################################

# Requires the use of scope operators (e.g. my, our)
use strict;
use warnings;

# Use the Cwd module to get the current working directory
use Cwd;

my $directory = Cwd::getcwd();

#if a file path arg is given, use it
if($ARGV[0]) {$directory=$ARGV[0];}

# Create a directory_handle scalar variable
my $directory_handle = undef ;

# Create an empty array to hold file names
my @files = ();

if(-e $directory)	
{
  # Directory exists
  # Open Directory
  opendir($directory_handle, $directory) or die("Could not open directory");
  # Get listing
  @files = readdir($directory_handle);
  # Close directory
  closedir($directory_handle);

  my $biggestFile = "";
  my $size = 0;
  
  # Iterate over the list of files using a foreach loop
  foreach my $file (@files)
  {
    # Store the full file name;
    my $full_file = $directory . '/' . $file;
   
    #skip if directory   
    next if (-d $full_file);

    # Get the size (in bytes) of the file
    my $fileSize = -s $full_file; 
    
    #set size to biggest file size and its name 
    if($size < $fileSize){
	  $size = $fileSize;
	  $biggestFile =  $full_file;
	  }
  }  

  # Print the name of the file and the size
  if($size == 0) { 
    print("\n", $directory, " has no non-empty files\n\n")
  }
  else {
      print("\n", $biggestFile, " has size ", $size, "\n\n");
    }
  
}
