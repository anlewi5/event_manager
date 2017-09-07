require 'csv'
require 'erb'
require 'sunlight/congress'
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
  # lines.each do |line|
  #   columns = line.split(",")
  #   p columns
  # end
  #
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

#Iteration 3: Sunlight API

  # Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"
  #
  # def clean_zipcode(zipcode)
  #   zipcode.to_s.rjust(5,"0")[0..4]
  # end
  #
  # contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
  #
  # contents.each do |row|
  #   name = row[:first_name]
  #
  #   zipcode = clean_zipcode(row[:zipcode])
  #
  #   legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
  #
  #   legislator_names = legislators.collect do |legislator|
  #     "#{legislator.first_name} #{legislator.last_name}"
  #   end
  #
  #   legislators_string = legislator_names.join(", ")
  #
  #   puts "#{name} #{zipcode} #{legislators_string}"
  # end
  #
  #refactor...
  #
  # Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"
  #
  # def clean_zipcode(zipcode)
  #   zipcode.to_s.rjust(5,"0")[0..4]
  # end
  #
  # def legislators_by_zipcode(zipcode)
  #   legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
  #
  #   legislator_names = legislators.collect do |legislator|
  #     "#{legislator.first_name} #{legislator.last_name}"
  #   end
  #
  #   legislator_names.join(", ")
  # end
  #
  # contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
  #
  # contents.each do |row|
  #   name = row[:first_name]
  #
  #   zipcode = clean_zipcode(row[:zipcode])
  #
  #   legislators = legislators_by_zipcode(zipcode)
  #
  #   puts "#{name} #{zipcode} #{legislators}"
  # end
  #
#Iteration 4: Form Letters

  Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def legislators_by_zipcode(zipcode)
    Sunlight::Congress::Legislator.by_zipcode(zipcode)
  end

  def save_thank_you_letters(id,form_letter)
    Dir.mkdir("output") unless Dir.exists?("output")

    filename = "output/thanks_#{id}.html"

    File.open(filename,'w') do |file|
      file.puts form_letter
    end
  end

  contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

  template_letter = File.read "form_letter.erb"
  erb_template = ERB.new template_letter

  contents.each do |row|
    id = row[0]
    name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    legislators = legislators_by_zipcode(zipcode)

    form_letter = erb_template.result(binding)

    save_thank_you_letters(id,form_letter)
  end
