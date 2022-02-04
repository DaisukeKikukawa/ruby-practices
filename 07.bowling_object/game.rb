# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(input)
    @input = input
    frames = []
    one_frame_pinfall = []
    @input.split(',').each do |shot|
      one_frame_pinfall << shot
      if frames.size < 10
        if shot == 'X' || one_frame_pinfall.size >= 2
          frames << one_frame_pinfall.clone
          one_frame_pinfall.clear
        end
      else
        frames.last << shot
      end
    end
    @frames = frames.map { |frame| Frame.new(*frame) }
  end
end
