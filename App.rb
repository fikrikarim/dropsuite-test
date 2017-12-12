#!/usr/bin/ruby

require 'digest/md5'

# Takes the first argument from the command line to get a specific location
location = ARGV[0] || "."
location = location + "/**/*"

hash1 = {}

# Recursive search of the directory
Dir[location].each do |filename|
    # Skip directory
    next if File.directory?(filename)
    next if !File.size?(filename)

    # Store files with the same size on the same hash key
    size = File.size(filename)
    if hash1.has_key? size
        hash1[size].push filename
    else
        hash1[size] = [filename]
    end

end

# Array of files with same size. Will return [key, value]
files_with_same_size = hash1.max_by{|key, value| value.length }

# Check the files with identical size and compare their MD5 
# to ensure the content is really the same
hash2 = {}

files_with_same_size[1].each do |filename|
    key = Digest::MD5.hexdigest(IO.read(filename)).to_sym
    if hash2.has_key? key
        # puts "same file #{filename}"
        hash2[key].push filename
    else
        hash2[key] = [filename]
    end
end

# Array of files with identical MD5. Quite enough to search for identical files
identical_files = hash2.max_by{|key, value| value.length }
number_of_identical_files = identical_files[1].length

# # Read the content of the file
file = File.open(identical_files[1].first)
content = file.read
file.close

# Print the content and the number of identical files
puts "#{content} #{number_of_identical_files}"
