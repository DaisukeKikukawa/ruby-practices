#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative 'long_format'
require_relative 'short_format'

class Ls
  attr_reader :options, :files

  def initialize
    OptionParser.new do |opt|
      @options = {}
      opt.on('-a') { |n| @options[:a] = n }
      opt.on('-r') { |n| @options[:r] = n }
      opt.on('-l') { |n| @options[:l] = n }
      opt.parse(ARGV)
    end
    @files = Dir.glob('*').sort
  end

  def output
    include_dot_file if options[:a]
    r_option if options[:r]
    if options[:l]
      LongFormat.new(files).l_option
    else
      ShortFormat.new(files).output
    end
  end

  private

  def include_dot_file
    @files = Dir.glob('*', File::FNM_DOTMATCH).sort
  end

  def r_option
    @files = files.reverse
  end
end

ls = Ls.new
ls.output
