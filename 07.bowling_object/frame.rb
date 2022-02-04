# frozen_string_literal: true

require_relative "./shot.rb"

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_shot, second_shot = nil, third_shot = nil)
    @first_shot = Shot.new(first_shot).score
    @second_shot = Shot.new(second_shot).score
    @third_shot = Shot.new(third_shot).score
  end
  def score
    [@first_shot, @second_shot, @third_shot].sum
  end

  def strike?
    @first_shot == 10
  end

  def spare?
    [@first_shot, @second_shot].sum == 10 && !strike?
  end

  def firstshot_and_secondshot_score
    [@first_shot, @second_shot].sum
  end

  def firstshot_score
    @first_shot
  end
end
