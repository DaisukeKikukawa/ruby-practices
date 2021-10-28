# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('l')

filenames = ARGV

def print_filenames_l_option(filenames)
  lines_sum = 0
  filenames.each do |filename|
    text = File.read(filename)
    print text.lines.count.to_s.rjust(8)
    puts filename
    lines_sum += text.lines.count
  end
  if filenames.count > 1
    print lines_sum.to_s.rjust(8)
    puts 'total'
  end
end

def print_filenames(filenames)
  lines_sum = 0
  words_sum = 0
  bytes_sum = 0
  filenames.each do |filename|
    text = File.read(filename)
    print text.lines.count.to_s.rjust(8)
    print text.split(/\s+/).count.to_s.rjust(8)
    print text.bytesize.to_s.rjust(8)
    puts filename

    lines_sum += text.lines.count
    words_sum += text.split(/\s+/).count
    bytes_sum += text.bytesize
  end
  print lines_sum.to_s.rjust(8)
  print words_sum.to_s.rjust(8)
  print bytes_sum.to_s.rjust(8)
  puts 'total'
end

def print_input_l_option(input)
  puts input.size.to_s.rjust(8)
end

def print_input(input)
  print input.size.to_s.rjust(8)
  print input.join.split(/\s+/).count.to_s.rjust(8)
  puts input.join.bytesize.to_s.rjust(8)
end

if filenames.count >= 1
  if options['l']
    print_filenames_l_option(filenames)
  else
    print_filenames(filenames)
  end
else
  input = $stdin.readlines
  if options['l']
    print_input_l_option(input)
  else
    print_input(input)
  end
end
