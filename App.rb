# Takes the first argument from the command line to get a specific location
location = ARGV[0] || "."
location = location + "/**/*"

files = {}

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

    puts files
end