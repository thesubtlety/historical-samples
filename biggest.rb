#!/usr/bin/ruby

# File: biggest.rb
# Author: Me
# Usage biggest.rb [args]
#	Lists largest file in current working directory or specified dir.

directory = Dir.pwd
files = []
filesize = 0
size = 0
biggestFile = ""

#if file path given, use it
if(ARGV[0]) 
	directory = ARGV[0]
end


# if (directory)
# 	Dir.new(directory).entries.each{ |entry| files.push(entry) if File.file?(entry) }
# end

if (directory)
	Dir.new(directory).entries.each{ |entry| 
		next if File.directory?(entry) 
		filesize = File.size(entry) if File.exists?(entry)
		if size < filesize
			size = filesize
			biggestFile = entry
		end
	}
end

if (size == 0) 
	puts directory.to_s + " has no non-empty files\n " 
else 
	puts biggestFile.to_s + " has size " + (size / 1024^2).to_s + " kb "
end




