# frozen_string_literal: true

require 'etc'

class Entry
  attr_reader :name

  MODES = {
    'file' => '-',
    'directory' => 'd',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'fifo' => 'p',
    'link' => 'l',
    'socket' => 's'
  }.freeze

  def initialize(name)
    @name = name
    @metadata = File.new(File.absolute_path(name)).stat
  end

  def mode_permissions
    mode + permissions
  end

  def nlink
    @metadata.nlink
  end

  def user
    Etc.getpwuid(@metadata.uid).name
  end

  def group
    Etc.getgrgid(@metadata.gid).name
  end

  def size
    @metadata.size
  end

  def mtime
    @metadata.mtime.strftime('%b %e %R')
  end

  def blksize
    @metadata.blocks / 2 # OS側では1ブロックサイズ1024bytes, Ruby側では512bytesで計算されるため補正
  end

  private

  def mode
    MODES[@metadata.ftype]
  end

  def permissions
    binary = @metadata.mode.to_s(2)[-9..]
    binary.chars.each_slice(3).map do |r, w, x|
      "#{r == '1' ? 'r' : '-'}#{w == '1' ? 'w' : '-'}#{x == '1' ? 'x' : '-'}"
    end.join
  end
end
