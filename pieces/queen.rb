class Queen < Piece
  include SlidingPiece

  def initialize(board, color)
    super(board, color)
    @symbol = " \u2655 "
  end

  def move_dirs
    [[-1, -1], [-1, 1], [1, -1], [1, 1], [0, -1], [1, 0], [0, 1], [-1, 0]]
  end
end
