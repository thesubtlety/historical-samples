#!/usr/bin/python
# This was a quick and dirty excercise in Python without googling the answer. No error checking, etc...
# Check out the Python unicode page and the BitManipulation page for more info and probably the proper way to do this
# Ended up working for my purposes anyways: decoding the BsidesDC badge

import argparse

def main():

	#argparse is overkill for this, but was fun to play around with
	parser = argparse.ArgumentParser(description="Convert between ascii and binary and vice verse.")
	group = parser.add_mutually_exclusive_group(required=True)
	group.add_argument('--to_binary', action="store", dest="ascii", nargs="+", help="Convert ascii to bin")
	group.add_argument('--to_ascii', action="store", dest="bin", nargs="+", help="Convert binary to ascii")
	args = parser.parse_args()

	#Sends user input to the appropriate function
	if args.ascii is not None:
		to_binary(args.ascii)
	elif args.bin is not None:
		to_ascii(args.bin)

def to_binary(args):
	chars_bin = [bin(ord(each)) for each in [item for sublist in args for item in sublist]] 
	print " ".join([each[2:].zfill(8) for each in chars_bin])
	### The Stack Overflow way
	### print ''.join('{:08b}'.format(ord(each)) for each in args) 

def to_ascii(args):
	print "".join([(chr(int(str(each),2))) for each in args])
	### The Stack Overflow way
	### print "".join(chr(args[i:i+8],2)) for i in xrange(0, len(args), 8)) 

if __name__ == "__main__": main()
