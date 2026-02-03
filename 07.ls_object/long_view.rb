# frozen_string_literal: true

require_relative 'ls_view'

class LongView < LsView
  private

  def format
    max_nlink = @entries.map(&:nlink).max.to_s.size
    max_user = @entries.map { |entry| entry.user.size }.max
    max_group = @entries.map { |entry| entry.group.size }.max
    max_file_size = @entries.map(&:size).max.to_s.size

    formatted_entries = @entries.map do |entry|
      [
        entry.mode_permissions,
        entry.nlink.to_s.rjust(max_nlink),
        entry.user.ljust(max_user),
        entry.group.ljust(max_group),
        entry.size.to_s.rjust(max_file_size),
        entry.mtime,
        entry.name
      ].join(' ')
    end
    formatted_entries.unshift("total #{@entries.sum(&:blksize)}")
  end
end
