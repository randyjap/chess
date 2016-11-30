class NullPiece < Piece
  include Singleton

  def initialize
    @color = nil
    @symbol = "   "
  end

  def moves
    []
  end
end
