# frozen_string_literal: true

require_relative 'ls_file'
class LongFormat
  attr_reader :files

  def initialize(files)
    @files = files
  end

  def output
    total
    l_option_detail
  end

  def l_option_detail
    files.each do |file|
      stat = File::Stat.new(file)

      file_data = [
        stat.mode.to_s(8).rjust(6).chars,
        stat.nlink.to_s.rjust(2),
        Etc.getpwuid(File.stat(file).uid).name,
        Etc.getgrgid(File.stat(file).gid).name,
        stat.size.to_s.rjust(5),
        stat.ctime.strftime('%m %e %k:%M').gsub(/^0/, ''),
        file
      ]
      file_type_attribute = LsFile.new(file_data).file_type
      file_type_attribute << LsFile.new(file_data).permission
      file_data[0] = file_type_attribute
      puts file_data.join(' ')
    end
  end

  private

  def total
    count = []
    files.each do |file|
      stat = File::Stat.new(file)
      count << stat.blocks
    end
    puts "total #{count.sum}"
  end
end
