# frozen_string_literal: true

class ShortFormat
  attr_reader :files

  def initialize(files)
    @files = files
  end

  def output
    files_array = files.map { |x| x.to_s.ljust(20) }.each_slice(6).to_a
    files_array[0].zip(*files_array[1..-1]).each { |x| puts x.join(' ') }
  end
end
