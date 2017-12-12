# Takes the first argument from the command line to get a specific location
location = ARGV[0] || "."
location = location + "/**/*"

dir = Dir[location]
puts dir