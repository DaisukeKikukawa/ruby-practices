# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('l')

filenames = ARGV

if filenames.count >= 1
  lines_sum = 0
  words_sum = 0
  bytes_sum = 0
  if options['l']
    filenames.each do |filename|
      text = File.read(filename)
      print text.lines.count.to_s.rjust(8)
      puts filename.to_s
      lines_sum += text.lines.count
    end
    if filenames.count > 1
      print lines_sum.to_s.rjust(8)
      puts 'total'
    end
  else
    filenames.each do |filename|
      text = File.read(filename)
      print text.lines.count.to_s.rjust(8)
      print text.split(/\s+/).count.to_s.rjust(8)
      print text.bytesize.to_s.rjust(8)
      puts filename.to_s

      lines_sum += text.lines.count
      words_sum += text.split(/\s+/).count
      bytes_sum += text.bytesize
    end
    print lines_sum.to_s.rjust(8)
    print words_sum.to_s.rjust(8)
    print bytes_sum.to_s.rjust(8)
    puts 'total'
  end
else
  input = $stdin.readlines
  if options['l']
    puts input.size.to_s.rjust(8)
  else
    print input.size.to_s.rjust(8)
    print input.join.split(/\s+/).count.to_s.rjust(8)
    puts input.join.bytesize.to_s.rjust(8)
  end
end
