# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(inputs)
    input = inputs
    frames = []
    one_frame_pinfall = []
    input.split(',').each do |shot|
      one_frame_pinfall << shot
      if frames.size < 10
        if shot == 'X' || one_frame_pinfall.size == 2
          frames << one_frame_pinfall.clone
          one_frame_pinfall.clear
        end
      else
        frames.last << shot
      end
    end
    @frames = frames.map { |frame| Frame.new(*frame) }
  end

  def calc_game_score
    @frames.each_with_index.sum do |frame, index|
      if index < 9 && frame.strike?
        strike_bonus(frame, index)
      elsif index < 9 && frame.spare?
        frame.score + @frames[index + 1].first_shot_score
      else
        frame.score
      end
    end
  end
end

private

def strike_bonus(frame, index)
  if index < 8 && frame.strike? && @frames[index + 1].strike?
    frame.score + @frames[index + 1].score + @frames[index + 2].first_shot_score
  else
    frame.score + @frames[index + 1].first_shot_and_second_shot_score
  end
end
