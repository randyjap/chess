class Piece
  attr_reader :color

  def initialize(board, color)
    @board = board
    @color = color
  end

  def to_s
    @symbol.encode('utf-8')
  end

  def my_position
    idx_finder = @board.grid.flatten.index(self)
    row = idx_finder / 8
    col = idx_finder % 8
    [row, col]
  end

end



module SteppingPiece

  def moves
    positions = []
    move_diffs.each do |modification|
      current_position = my_position
      current_piece = NullPiece.instance

      next_position = translate(current_position, modification)
      next unless next_position.all? { |pos| pos.between?(0, 7) }
      positions << next_position

    end
    positions
  end

  def translate(original, modification)
    y, x = original
    y2, x2 = modification
    [y + y2, x + x2]
  end
end

module SlidingPiece

  def moves
    positions = []
    move_dirs.each do |modification|
      current_position = my_position
      current_piece = NullPiece.instance
      while current_piece.is_a?(NullPiece)
        next_position = translate(current_position, modification)
        break unless next_position.all? { |pos| pos.between?(0, 7) }
        positions << next_position
        current_piece = @board[next_position]
        current_position = next_position
      end
    end
    positions
  end

  def translate(original, modification)
    y, x = original
    y2, x2 = modification
    [y + y2, x + x2]
  end
end
