# frozen_string_literal: true

require 'optparse'
require 'etc'
options = ARGV.getopts('a', 'l', 'r')

def print_three_column(files)
  if (files.size % 3).zero?
    slice_number = files.size / 3 + 1
  else
    slice_number = files.size / 3 + files.size % 3
  end

  lines = files.each_slice(slice_number).to_a

  (lines[0].size - lines[-1].size).times { lines[-1].push('') } unless (files.size % 3).zero?

  transposed_array = lines.transpose

  spaces = files.max_by { |x| x.size }.size

  transposed_array.each do |i|
    print i[0] + ' ' * (spaces - i[0].size + 10)
    print i[1] + ' ' * (spaces - i[1].size + 10)
    print i[2]
    print("\n")
  end
end

def l_option(files)
  total = 0
  files.each do |t|
    stat = File::Stat.new(t)
    total += stat.blocks
  end

  puts "total#{total}"

  files.each do |x|
    stat = File::Stat.new(x)
    mode_number = format('%o', stat.mode)
    print lists_type(stat.ftype)
    print lists_mode(mode_number[-3]) + lists_mode(mode_number[-2]) + lists_mode(mode_number[-1])
    print stat.nlink.to_s.rjust(3)
    print Etc.getpwuid(stat.uid).name.ljust(7)
    print Etc.getgrgid(stat.gid).name.ljust(7)
    print stat.size.to_s
    print stat.mtime.strftime('%-B%e %k:%M').rjust(12)
    print x
    print "\n"
  end
end

def lists_type(ftype)
  {
    "file": '-',
    "directory": 'd',
    "characterSpecial": 'c',
    "blockSpecial": 'b',
    "fifo": 'f',
    "link": 'l',
    "socket": 's'
  }[ftype.to_sym]
end

def lists_mode(mode)
  {
    "0": '---',
    "1": '--x',
    "2": '-w-',
    "3": '-wx',
    "4": 'r--',
    "5": 'r-x',
    "6": 'rw-',
    "7": 'rwx'
  }[mode.to_sym]
end

if options['a']
  files = Dir.glob('*', File::FNM_DOTMATCH).sort
else
  files = Dir.glob('*').sort
end

if options['r']
  files = files.reverse
end

if options['l']
  l_option(files)
else
  print_three_column(files)
end
