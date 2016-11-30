class King < Piece
  include SteppingPiece

  def initialize(board, color)
    super(board, color)
    @symbol = " \u2654 "
  end

  def move_diffs
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  end

end
