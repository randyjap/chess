class Bishop < Piece
  include SlidingPiece

  def initialize(board, color)
    super(board, color)
    @symbol = " \u2657 "
  end

  def move_dirs
    [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end
end
