# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :number, :first_shot, :second_shot

  def initialize(number, first_shot, second_shot = nil, third_shot = nil)
    @number = number
    @first_shot = Shot.new(first_shot)
    @second_shot = Shot.new(second_shot)
    @third_shot = Shot.new(third_shot)
  end

  def score(next_frame, next_next_frame)
    if last?
      base_score
    elsif strike?
      strike_score(next_frame, next_next_frame)
    elsif spare?
      spare_score(next_frame)
    else
      base_score
    end
  end

  def strike?
    first_shot.score == 10
  end

  def last?
    @number == 10
  end

  def base_score
    [first_shot, second_shot, @third_shot].sum(&:score)
  end

  private

  def spare?
    !strike? && [first_shot, second_shot].sum(&:score) == 10
  end

  def strike_score(next_frame, next_next_frame)
    if foundation?
      10 + next_frame.first_shot.score + next_frame.second_shot.score
    elsif next_frame.strike?
      20 + next_next_frame.first_shot.score
    else
      10 + next_frame.base_score
    end
  end

  def spare_score(next_frame)
    10 + next_frame.first_shot.score
  end

  def foundation?
    @number == 9
  end
end
