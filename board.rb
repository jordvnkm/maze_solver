

class Board
  attr_reader :grid, :start, :end

  def initialize(filename)
    @grid = parse(filename)
    @start = find_value("S")
    @end = find_value("E")
  end

  def render
    @grid.each do |row|
      puts row.join
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x,y = pos
    @grid[x][y] = val
  end

  def find_value(val)
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |space, col_idx|
        return [row_idx, col_idx] if space == val
      end
    end
    nil
  end

  def parse(filename)
    grid = []
    rows = File.readlines(filename).map(&:chomp)
    rows.each do |row|
      grid.push(row.chars)
    end
    grid
  end

  def update(next_pos, prev_pos)
    self[next_pos] = :P
    self[prev_pos] = :X
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new("maze1.txt")
  board.render
  p board.start
  p board.end
end
