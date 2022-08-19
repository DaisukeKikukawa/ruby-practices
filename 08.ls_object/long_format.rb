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
        build_data(ls_file)
      end
      puts file_data
  end

  private

  def build_data(ls_file)
    [
      ls_file.file_type + ls_file.stat_mode,
      ls_file.hard_links,
      ls_file.owner_id,
      ls_file.owner_group,
      ls_file.file_size,
      ls_file.creation_time,
    ].join(' ')
  end

  def total
    count = []
    files.each do |file|
      stat = File::Stat.new(file)
      count << stat.blocks
    end
    puts "total #{count.sum}"
  end
end
