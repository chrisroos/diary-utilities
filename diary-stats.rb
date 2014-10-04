<<-README
Print some very basic stats (earliest, latest entries along with a total)
as well as the missing days.
README

require 'date'

entries = []
missing_entries = []

Dir['*-personal.md'].each do |file|
  if file =~ /(\d{4}-\d{2}-\d{2})/
    date = Date.parse($1)
    entries << date unless entries.include?(date)
  end
end

earliest_date = entries.sort.first
latest_date = entries.sort.last

(earliest_date..Date.today).each do |date|
  missing_entries << date unless entries.include?(date)
end

puts "## Personal diary stats"
puts "Earliest entry: #{earliest_date}"
puts "Latest entry: #{latest_date}"
puts "Total entries: #{entries.length}"
puts "Missing entries: #{missing_entries.length}"

missing_entries.each do |date|
  puts date.strftime('%a %d %b %Y')
end
