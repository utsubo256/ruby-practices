# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(frame_scores)
    @frames = frame_scores.each.with_index(1).map { |shots, i| Frame.new(i, *shots) }
  end

  def score
    total_score = 0
    (1..10).each { |frame_number| total_score += calculate_score(@frames[frame_number - 1]) }
    total_score
  end

  private

  def calculate_score(frame)
    return frame.score if frame.last?

    next_frame = @frames[frame.number]
    if frame.strike?
      strike_score(frame, next_frame)
    elsif frame.spare?
      spare_score(next_frame)
    else
      frame.score
    end
  end

  def strike_score(frame, next_frame)
    if frame.foundation?
      10 + next_frame.first_shot.score + next_frame.second_shot.score
    elsif next_frame.strike?
      next_next_frame = @frames[frame.number + 1]
      20 + next_next_frame.first_shot.score
    else
      10 + next_frame.score
    end
  end

  def spare_score(next_frame)
    10 + next_frame.first_shot.score
  end
end
