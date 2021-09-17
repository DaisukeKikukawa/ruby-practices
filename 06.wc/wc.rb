# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('l')

filename = ARGV

if filename.count.zero?
  input = $stdin.readlines
  print input.size.to_s.rjust(8)
  print input.join.split(/\s+/).count.to_s.rjust(8)
  puts input.join.bytesize.to_s.rjust(8)
end

lines_sum = 0
words_sum = 0
bytes_sum = 0

if options['l']
  filename.each do |n|
    file = File.read(n)
    print file.lines.count.to_s.rjust(8)
    puts " #{n}"

    lines_sum += file.lines.count
  end

  unless filename.count.zero?
    print lines_sum.to_s.rjust(8)
    puts ' total'
  end

end

unless options['l']
  if filename.count == 1
    filename.each do |n|
      file = File.read(n)
      print file.lines.count.to_s.rjust(8)
      print file.split(/\s+/).count.to_s.rjust(8)
      print file.bytesize.to_s.rjust(8)
      puts " #{n}"
    end
  end

  if filename.count > 1
    filename.each do |n|
      file = File.read(n)
      print file.lines.count.to_s.rjust(8)
      print file.split(/\s+/).count.to_s.rjust(8)
      print file.bytesize.to_s.rjust(8)
      puts " #{n}"

      lines_sum += file.lines.count
      words_sum += file.split(/\s+/).count
      bytes_sum += file.bytesize
    end
    print lines_sum.to_s.rjust(8)
    print words_sum.to_s.rjust(8)
    print bytes_sum.to_s.rjust(8)
    puts ' total'
  end
end
