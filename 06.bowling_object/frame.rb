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

  def score
    [first_shot, second_shot, @third_shot].sum(&:score)
  end

  def strike?
    first_shot.score == 10
  end

  def spare?
    !strike? && [first_shot, second_shot].sum(&:score) == 10
  end

  def foundation?
    @number == 9
  end

  def last?
    @number == 10
  end
end
