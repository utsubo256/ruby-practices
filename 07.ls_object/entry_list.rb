# frozen_string_literal: true

require_relative 'entry'
require_relative 'default_formatter'
require_relative 'long_formatter'

class EntryList
  def initialize(options)
    @options = options
    @entries = Dir.entries('.').map { |entry_name| Entry.new(entry_name) }
  end

  def display
    filtered_entries = filter(@entries)
    sorted_entries = sort(filtered_entries)
    puts format(sorted_entries)
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

  def format(entries)
    formatter = @options[:l] ? LongFormatter.new(entries) : DefaultFormatter.new(entries)
    formatter.format
  end
end
