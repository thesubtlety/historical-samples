#!/usr/bin/ruby
# 
# Make AD compatible list given list of names
# Arguments: txt file of names separated by line breaks


unless (ARGV[0]) 
	puts "\tUsage: convertNames.rb <namelist>\n"+
		 "\tReverses names into 'Lastname, Firstname' format for AD compatible list of names\n"+
		 "\t<namelist> names separated by newlines\n"
		exit
		end

input = ARGV[0]
if not File.file?(input)
	puts "File not found"
	abort
end


#Feed into array separating by newlines
nameList = open(input, "a+").map { |line| line.split('/\r?\n/')[0]}


#Remove extraneous stuff
nameList.each do |x| 
	x.to_s.gsub!(/^Dr.?|^Mr.?|^Ms.?|^Mrs.?/,'')
	x.to_s.gsub!(/^\s*/, '') 
end


newNames = []
#Reverse names, inserting commas after lastname
nameList.map do |name| 
	newNames << name.to_s.split(' ').reverse.join(', ')
end

#Outputs reversed names into new file
File.open('AD Compatible.txt', "w") do |f|
	f.puts "AD Compatible Names - " + Time.now.to_s
	f.puts newNames
end







