<<-README
Assuming a directory of files named 'yyyy-mm-dd-*.md'
this script will update the creation timestamps to
yyy-mm-dd 09:00.

This allows me to use tools like `find` to list files
based on timestamp criteria.
README

require 'time'
require 'fileutils'

Dir['*.md'].each do |file|
  if file =~ /(\d{4}-\d{2}-\d{2})/
    date = $1
    time = '09:00'

    timestamp = Time.parse("#{date} #{time}")

    FileUtils.touch [file], mtime: timestamp, nocreate: true
  end
end
