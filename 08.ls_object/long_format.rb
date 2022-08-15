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
      file_data = files.map do |file|
        ls_file = LsFile.new(file)
        ls_file.build_data(file)
      end
      puts file_data
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
