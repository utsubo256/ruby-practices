# frozen_string_literal: true

require_relative 'ls_view'

class GridView < LsView
  COLUMN = 3

  private

  def format
    entry_names = @entries.map(&:name)
    column_number = entry_names.size.ceildiv(COLUMN)
    return [] if column_number.zero?

    sliced_entry_names = entry_names.each_slice(column_number).to_a
    aligned_entries = sliced_entry_names.map do |names|
      names.map { |name| name.ljust(names.map(&:size).max + 2) }
    end
    aligned_entries[-1].size.upto(column_number - 1) { aligned_entries[-1] << nil }
    aligned_entries.transpose.map(&:join)
  end
end
