class Display
  attr_reader :cursor

  def initialize
    @cursor = Cursor.new([0,0], board = Board.new)
  end

  def play
    while true
      render
      @cursor.get_input
    end
  end

  def render
    cursor_y, cursor_x = @cursor.cursor_pos
    system("clear")
    puts "CHECKMATE" if @cursor.board.checkmate?(:white)
    puts " " + ('A'..'H').to_a.map { |e| ' ' + e + ' ' }.join('').colorize( @cursor.board.in_check?(:white) ? :red : :white)
    @cursor.board.grid.each_with_index do |set, set_idx|
      row = set.map.with_index do |el, col_idx|
        background = ((set_idx + col_idx).even? ? :light_red : :light_black)
        if set_idx == cursor_y && col_idx == cursor_x
          el.to_s.colorize(:color => :yellow, :background => :red)
        else
          el.to_s.colorize(:color => el.color, :background => background)
        end
      end.join("")
      puts "#{8 - set_idx}" + row
    end
  end
end
