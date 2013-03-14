#!/usr/bin/ruby
#
#simple word count of given file

if ARGV.empty? 
	puts "\tUsage: frequency <filepath>\n"+
		 "\tCounts the word frequency in a given file\n"
		 exit
		 end

filename = ARGV[0].chomp
if not File.file?(filename)
	puts "File " + Dir.pwd + "/#{filename} not found"
	abort
end

#make a new array for all the words
all_words = Array.new

#open the file, and for each word, put it into the array
File.open(filename) do |word| all_words = word.read.split 
end

#declare a new hash, the zero defaults the hash to 0 rather than nil
frequency = Hash.new(0)

#for every word in array, create an entry in the hash table.
#if the entry(key) already exists, add one(value)
all_words.each do |word| frequency[word] += 1 
end

#sort the hash by frequency number
frequency = frequency.sort_by { |word, frequency| frequency }.reverse 

#got an error "Broken pipe - <STDOUT> (Errno::EPIPE)" when using "| head" 
#see here for much more info: http://superuser.com/questions/554855/how-can-i-fix-a-broken-pipe-error
#and here for the begin/rescue http://stackoverflow.com/questions/2845507/how-do-you-pipe-output-from-a-ruby-script-to-head-without-getting-a-broken-pip
#this happens when head closes the standard output stream after it has read the data it needs and before puts has finished, so catch and suppress

output = []
frequency.each { |word, frequency| output << word + ": " + frequency.to_s }

begin 
	puts output
rescue Errno::EPIPE
	abort
end

