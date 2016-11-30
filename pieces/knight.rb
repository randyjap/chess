class Knight < Piece
  include SteppingPiece

  def initialize(board, color)
    super(board, color)
    @symbol = " \u2658 "
  end

  def move_diffs
    [[-2, -1], [-1, -2], [-2, 1], [-1, 2], [1, -2], [2, -1], [1, 2], [2, 1]]
  end


end
