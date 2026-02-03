# frozen_string_literal: true

require_relative 'entry'
require_relative 'grid_view'
require_relative 'long_view'

class LsCommand
  def initialize(options)
    @options = options
    @entries = Dir.entries('.').map { |entry_name| Entry.new(entry_name) }
  end

  def execute
    filtered_entries = filter(@entries)
    sorted_entries = sort(filtered_entries)
    ls_view = @options[:l] ? LongView.new(sorted_entries) : GridView.new(sorted_entries)
    ls_view.display
  end

  private

  def filter(entries)
    return entries if @options[:a]

    entries.reject { |entry| entry.name.start_with?('.') }
  end

  def sort(entries)
    sorted_entries = entries.sort_by do |entry|
      key = entry.name.downcase.gsub(/[.\-_]/, '')
      key.empty? ? entry.name : key # '.'と'..'の位置を確定させる。gsub(/[.\-_]/, '')によってどちらも空文字になるので、そのままだとDir.entries()の出力順に依存する
    end
    sorted_entries = sorted_entries.reverse if @options[:r]
    sorted_entries
  end
end
