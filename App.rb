# Takes the first argument from the command line to get a specific location
location = ARGV[0] || "."
location = location + "/**/*"

files = {}

# Recursive search of the directory
Dir[location].each do |filename|
    # Skip directory
    next if File.directory?(filename)

    # Store files with the same size on the same hash key
    size = File.size(filename)
    if files.has_key? size
        files[size].push filename
    else
        files[size] = [filename]
    end

end

# Array of list of identical files. Will return [key, value]
identical_files = files.max_by{|key, value| value.length }
number_of_files = identical_files[1].length

# Read the content of the file
file = File.open(identical_files[1].first)
content = file.read
file.close

# Print the content and the number of identical files
puts "#{content} #{number_of_files}"