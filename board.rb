class Board
  attr_accessor :grid

  STARTING_POSITIONS = { :rook => [[0, 0], [0, 7], [7, 0], [7, 7]],
    :knight => [[0, 1], [0, 6], [7, 1], [7, 6]],
    :bishop => [[0,2],[0,5],[7,2],[7,5]],
    :queen => [[0,3],[7,3]], :king => [[0,4],[7,4]] }

  def initial_board
    grid = Array.new(8){ Array.new(8) }
    STARTING_POSITIONS[:rook].each do |y,x|
      grid[y][x] = Rook.new(self, y.odd? ? :white : :black)
    end

    STARTING_POSITIONS[:knight].each do |y,x|
      grid[y][x] = Knight.new(self, y.odd? ? :white : :black)
    end

    STARTING_POSITIONS[:bishop].each do |y,x|
      grid[y][x] = Bishop.new(self, y.odd? ? :white : :black)
    end

    STARTING_POSITIONS[:queen].each do |y,x|
      grid[y][x] = Queen.new(self, y.odd? ? :white : :black)
    end

    STARTING_POSITIONS[:king].each do |y,x|
      grid[y][x] = King.new(self, y.odd? ? :white : :black)
    end

    grid[1].map! do |pos|
      Pawn.new(self, :black)
    end

    grid[6].map! do |pos|
      Pawn.new(self, :white)
    end

    grid[2..5].map! do |row|
      row.map! do |pos|
        NullPiece.instance()
      end
    end

    grid
  end

  def initialize
    @grid = initial_board
  end

  def move_piece(start_pos, end_pos, color) # moves the piece
    if move_valid?(start_pos, end_pos, color)
      if self[end_pos].class == NullPiece
        self[start_pos], self[end_pos] = self[end_pos], self[start_pos] # swaps the two positions
      else
        self[end_pos] = self[start_pos]
        self[start_pos] = NullPiece.instance
      end
    end
  end

  def in_check?(color)
    k = @grid.flatten.find { |piece| piece.color == color && piece.is_a?(King) }
    k_pos = k.my_position

    @grid.flatten.any? do |piece|
      piece.color != color && piece.moves.include?(k_pos)
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)
    results = []
    all_my_pieces = @grid.flatten.select { |piece| piece.color == color }
    all_required_positions = all_my_pieces.map { |piece| piece.my_position }
    all_required_positions.each do |pos|
      self[pos].moves.each do |move|
        begin
          inner_temp = self.dup
          inner_temp.move_piece(pos, move, color)
          results << move unless inner_temp.in_check?(color)
        rescue
          next
        end
      end
    end
    results.all? { |result| result == true }
  end

  def dup
    new_board = Board.new
    new_board.grid.flatten.map! { NullPiece.instance }

    @grid.flatten.each do |piece|
      clone_piece(new_board, piece)
    end
    new_board
  end

  def clone_piece(new_board, piece)
    if piece.class != NullPiece
      new_board[piece.my_position] = piece.class.new(new_board, piece.color)
    end
  end

  def move_valid?(start_pos, end_pos, color)
    raise "Piece unable to move there" unless self[start_pos].moves.include?(end_pos)
    raise "Not your piece" unless self[start_pos].color == color
    raise "Cannot attack same color" if self[end_pos].color == color
    raise "No piece at start position!" if self[start_pos].class == NullPiece # error if starting piece is a null piece
    raise "Position out of bounds!" unless in_bounds(end_pos) #error if end position is out of bounds
    true
  end

  def in_bounds(cursor_pos) # checks if the given positions is within the board
    cursor_pos.all? { |x| x.between?(0, 7) }
  end

  def [](pos) # our syntactic sugar to get position without mantually splitting it
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    @grid[x][y] = value
  end
end
