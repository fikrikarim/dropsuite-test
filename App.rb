# Takes the first argument from the command line to get a specific location
location = ARGV[0] || "."
location = location + "/**/*"

Dir[location].each do |filename|
    # Skip directory
    next if File.directory?(filename)
    puts filename
end