# frozen_string_literal: true

class DefaultFormatter
  COLUMN = 3

  def initialize(entries)
    @entries = entries
  end

  def format
    entry_names = @entries.map(&:name)
    column_number = entry_names.size.ceildiv(COLUMN)
    return [] if column_number.zero?

    sliced_entry_names = entry_names.each_slice(column_number).to_a
    aligned_entries = sliced_entry_names.map do |names|
      names.map { |name| name.ljust(names.map(&:size).max + 2) }
    end
    (column_number - aligned_entries[-1].size).times { aligned_entries[-1] << nil }
    aligned_entries.transpose.map(&:join)
  end
end
