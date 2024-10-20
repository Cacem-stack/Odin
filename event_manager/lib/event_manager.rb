require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'
require 'pry-byebug'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone(phone)
  if phone != nil
    phone = phone.scan(/\d+/).map(&:to_s)
    phonejoin = phone.join("")

    if phonejoin.length == 10
      return phone.join("-")
    elsif phonejoin.length == 11 && phonejoin.to_s[0] == "1"
      return phone.join("-")[1..10]
    else
      return "000-000-0000"
    end
  else
    return "000-000-0000"
  end
end


def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def save_info_letter(info_letter, hourhash)
  Dir.mkdir('info') unless Dir.exist?('info')

  filename = "info/letter.html"

  File.open(filename, 'w')
  file.puts info_letter
end

def tophours(date, hoursarr, hourshash)
  time = DateTime.strptime(date, "%m/%d/%y %k:%M")
  hour = time.strftime("%k")
  hour = hour.to_i
  hourshash[hour] += 1
end

def topdays(date, dayarr, dayhash)
  day = DateTime.strptime(date, "%m/%d/%y %k:%M").wday
  dayhash[day] += 1
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
info_letter = File.read('info_letter.erb')
info = File.read('form_letter.erb')
erb_template = ERB.new template_letter

hoursarr = Array(0..23)
hourshash = hoursarr.to_h {|i| [i, 0]}

dayarr = Array(0..6)
dayhash = dayarr.to_h {|i| [i, 0]}

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  puts form_letter

  tophours(row[:regdate], hoursarr, hourshash)
  topdays(row[:regdate], dayarr, dayhash)

  save_thank_you_letter(id,form_letter)
end

puts "\n"

puts "Popular hours:"
hourshash.each do |k, v|
  puts "#{k}: #{v} registrations." if v > 0
end

puts "\n"

puts "Popular Days:"
dayhash.each do |k, v|
  if k == 0 && v > 1
    puts "sunday: #{v} registrations."
  elsif k == 1 && v > 1
    puts "monday: #{v} registrations."
  elsif k == 2 && v > 1
    puts "tuesday: #{v} registrations."
  elsif k == 3 && v > 1
    puts "wednesday: #{v} registrations."
  elsif k == 4 && v > 1
    puts "thursday: #{v} registrations."
  elsif k == 5 && v > 1
    puts "friday: #{v} registrations."
  elsif k == 6 && v > 1
    puts "saturday: #{v} registrations."
  end
end
