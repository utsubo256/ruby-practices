# frozen_string_literal: true

class LsView
  def initialize(entries)
    @entries = entries
  end

  def display
    puts format
  end
end
