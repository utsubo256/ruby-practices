# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(frame_scores)
    @frames = frame_scores.map.with_index(1) { |shots, i| Frame.new(i, *shots) }
    link_next_frames
  end

  def score
    @frames.sum(&:score)
  end

  private

  def link_next_frames
    @frames.each_cons(2) { |frame, next_frame| frame.next_frame = next_frame }
  end
end
