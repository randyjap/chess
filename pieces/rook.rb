class Rook < Piece
  include SlidingPiece

  def initialize(board, color)
    super(board, color)
    @symbol = " \u2656 "
  end

  def move_dirs
    [[0, -1], [1, 0], [0, 1],[-1, 0]]
  end

end
