# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(frame_scores)
    @frames = frame_scores.map.with_index(1) { |shots, i| Frame.new(i, *shots) }
  end

  def score
    @frames.each_with_index.sum do |frame, i|
      next_frame = @frames[i + 1]
      next_next_frame = @frames[i + 2]
      frame.score(next_frame, next_next_frame)
    end
  end
end
