#!/usr/bin/env ruby
require 'colorize'
require 'singleton'
require 'byebug'

load './board.rb'
load './pieces/pieces.rb'
load './pieces/bishop.rb'
load './pieces/king.rb'
load './pieces/knight.rb'
load './pieces/null_piece.rb'
load './pieces/pawn.rb'
load './pieces/queen.rb'
load './pieces/rook.rb'
load './display.rb'
load './cursor.rb'
load './player.rb'

if __FILE__ == $PROGRAM_NAME
  game = Display.new
  game.play
  # puts game.cursor.board == game.cursor.board.dup
  # puts game.cursor.board.grid[0][0] == game.cursor.board.dup.grid[0][0]
end
