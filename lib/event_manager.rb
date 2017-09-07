puts "EventManager initialized."

# contents = File.read "event_attendees.csv"
# puts contents
#
# lines = File.readlines "event_attendees.csv"
# lines.each do |line|
#   puts line
# end
#
# lines = File.readlines "event_attendees.csv"
# lines.each do |line|
#   columns = line.split(",")
#   p columns
# end

lines = File.readlines "event_attendees.csv"
lines.each do |line|
  columns = line.split(",")
  name = columns[2]
  puts name
end
