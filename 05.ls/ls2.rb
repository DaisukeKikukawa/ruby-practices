# frozen_string_literal: true

require 'optparse'
require 'etc'
options = ARGV.getopts('a', 'l', 'r')


DividedIntoThree = 3

def print_three_column(files)
  slice_number = if (files.size % DividedIntoThree).zero?
                   files.size / DividedIntoThree + 1
                 else
                   files.size / DividedIntoThree + files.size % DividedIntoThree
                 end

  lines = files.each_slice(slice_number).to_a

  max_size = lines.map(&:size).max
  lines.map! { |it| it.values_at(0...max_size) }

  transposed_array = lines.transpose

  transposed_array.each do |x|
    x.each do |y|
      print y.to_s.ljust(24)
    end
    print "\n"
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

files = if options['a']
          Dir.glob('*', File::FNM_DOTMATCH).sort
        else
          Dir.glob('*').sort
        end

files = files.reverse if options['r']

if options['l']
  l_option(files)
else
  print_three_column(files)
end
