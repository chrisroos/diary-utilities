<<-README
# Usage example:

## Report on all work entries
$ find . -name "*-work.md" \
  | xargs grep "## " \
  | ruby time-tracker.rb

## Report on work entries between 28th July and 4th August
$ find . -name "*-work.md" \
  -newerBt "2014-07-28" \
  -not \
  -newerBt "2014-08-04" \
  | xargs grep "## " \
  | ruby time-tracker.rb

__NOTE.__ These examples rely on the file creation timestamps
matching the date in the filename. Use `update-timestamps.rb`
to update these timestamps.
README

require 'time'

def seconds_to_hms(seconds)
  seconds = Integer(seconds)

  hours = seconds / 60 / 60
  seconds -= hours * 60 * 60
  minutes = seconds / 60
  seconds -= minutes * 60

  duration = [hours, minutes, seconds]
  duration.map { |d| format("%02d", d) }.join(':')
end

tasks = Hash.new { |hash, key| hash[key] = 0 }
total_duration_in_seconds = 0

STDIN.read.split("\n").each do |line|
  line =~ /(\d{4}-\d{2}-\d{2}).*(\d{2}:\d{2}) - (\d{2}:\d{2}) - (.*)/
  date = $1
  start_time = $2
  end_time = $3
  category = $4

  if date && start_time && end_time && category
    started_at = Time.parse("#{date} #{start_time}")
    finished_at = Time.parse("#{date} #{end_time}")

    duration_in_seconds = finished_at - started_at

    total_duration_in_seconds += duration_in_seconds

    tasks[category] += duration_in_seconds
  else
    puts "Skipping: #{line}"
  end
end

longest_category_length = tasks.keys.collect { |category| category.length }.max

tasks.sort.each do |category, duration_in_seconds|
  puts "#{category.ljust(longest_category_length + 1)}: #{seconds_to_hms(duration_in_seconds)}"
end

puts ""
puts "Total calculated duration: #{seconds_to_hms(total_duration_in_seconds)}"
