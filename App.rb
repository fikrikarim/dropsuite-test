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

def find_duplicates(hash, i = 0, largest_duplicates = [[], []])
    # Array of files with same size. Will return [key, value]
    files_with_same_size_1 = hash.max_by(i+2){|key, value| value.length }[i]
    files_with_same_size_2 = hash.max_by(i+2){|key, value| value.length }[i+1]
    # puts files_with_same_size

    # Array of files with identical MD5. Quite enough to search for identical files
    files_with_same_hash = ArrayToMD5(files_with_same_size_1).max_by{|key, value| value.length }

    if largest_duplicates[1].length < files_with_same_hash[1].length
        largest_duplicates = files_with_same_hash
    end

    if largest_duplicates[1].length > files_with_same_size_2[1].length
        return largest_duplicates
    else
        find_duplicates(hash, i+1, largest_duplicates)
    end
end

def ArrayToMD5(array)
    # puts array
    # Check the files with identical size and compare their MD5 
    # to ensure the content is really the same
    hash2 = {}
    array[1].each do |filename|
        key = Digest::MD5.hexdigest(IO.read(filename)).to_sym
        if hash2.has_key? key
            # puts "same file #{filename}"
            hash2[key].push filename
        else
            hash2[key] = [filename]
        end
    end
    return hash2
end

# Read the content of the file
final_duplicates = find_duplicates(hash1)
file = File.open(final_duplicates[1].first)
content = file.read
file.close

# # Print the content and the number of identical files
puts "#{content} #{final_duplicates[1].length}"