class Pawn < Piece
  include SteppingPiece

  def initialize(board, color)
    super(board, color)
    @symbol = " \u2659 "
  end

  def move_diffs
    [[1, 0], [-1, 0]]
  end

  def empty?

  end

  def move_into_check(to_pos)

  end

end
