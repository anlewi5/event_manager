require 'csv'
puts "EventManager initialized."

#Iteration 0: loading a file

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
  #
  # lines = File.readlines "event_attendees.csv"
  # lines.each do |line|
  #   columns = line.split(",")
  #   name = columns[2]
  #   puts name
  # end

#Iteration 1: parsing with csv

  # contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
  # contents.each do |row|
  #   name = row[:first_name]
  #   puts name
  # end
  #
  # contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
  # contents.each do |row|
  #   name = row[:first_name]
  #   zipcode = row[:zipcode]
  #   puts "#{name} #{zipcode}"
  # end

#Iteration 2: cleaning up zipcode

  # contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
  #
  # contents.each do |row|
  #   name = row[:first_name]
  #   zipcode = row[:zipcode]
  #
  #   if zipcode.nil?
  #     zipcode = "00000"
  #   elsif zipcode.length < 5
  #     zipcode = zipcode.rjust 5, "0"
  #   elsif zipcode.length > 5
  #     zipcode = zipcode[0..4]
  #   end
  #
  #   puts "#{name} #{zipcode}"
  # end
  # 
  # def clean_zipcode(zipcode)
  #   zipcode.to_s.rjust(5,"0")[0..4]
  # end
  #
  # contents.each do |row|
  #   name = row[:first_name]
  #
  #   zipcode = clean_zipcode(row[:zipcode])
  #
  #   puts "#{name} #{zipcode}"
  # end
