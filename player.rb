require "byebug"

class Player
  attr_reader :current_position
  def initialize(board)
    @board = board
    @current_position = board.start
    @direction = :right
    @move_deltas = {
      :right => [0,1],
      :left => [0,-1],
      :up => [-1,0],
      :down => [1, 0]
    }
    @wall_deltas = {
      :right => [1,0],
      :left => [-1,0],
      :up => [0,1],
      :down => [0,-1]
    }
  end

  def check_wall_deltas(delta)
    current_x, current_y = @current_position
    delta_x = current_x + @wall_deltas[delta][0]
    delta_y = current_y + @wall_deltas[delta][1]
    [delta_x, delta_y]
  end

  def check_move_deltas(delta)
    current_x, current_y = @current_position
    delta_x = current_x + @move_deltas[delta][0]
    delta_y = current_y + @move_deltas[delta][1]
    [delta_x, delta_y]
  end

  def valid_move?(delta)
    if @board[check_wall_deltas(delta)] == "*" && @board[check_move_deltas(delta)] == " "
      return true
    else
      false
    end
  end

  def wall_on_right?
    @board[check_wall_deltas(@direction)] == "*"
  end

  def turn_right
    if @direction == :right
      @direction = :down
    elsif @direction == :down
      @direction = :left
    elsif @direction == :left
      @direction = :up
    elsif @direction == :up
      @direction = :right
    end
  end

  def turn_left
    if @direction == :right
      @direction = :up
    elsif @direction == :down
      @direction = :right
    elsif @direction == :left
      @direction = :down
    elsif @direction == :up
      @direction = :left
    end
  end

  def update_current_position(pos)
    @current_position = pos
  end


  def get_move
    #return position 1 away from current, where to go
    #byebug
    if @direction == :right
      if !wall_on_right?
        @direction = :down
        return check_move_deltas(:down)
      elsif valid_move?(:right)
        return check_move_deltas(:right)
      else
        turn_left
        return get_move
      end

    elsif @direction == :left
      if !wall_on_right?
        @direction = :up
        return check_move_deltas(:up)
      elsif valid_move?(:left)
        return check_move_deltas(:left)
      else
        turn_left
        return get_move
      end

    elsif @direction == :up

      if !wall_on_right?
        @direction = :right
        return check_move_deltas(:right)
      elsif valid_move?(:up)
        return check_move_deltas(:up)
      else
        turn_left
        return get_move
      end

    elsif @direction == :down
      if !wall_on_right?
        @direction = :left
        return check_move_deltas(:left)
      elsif valid_move?(:down)
        return check_move_deltas(:down)
      else
        turn_left
        return get_move
      end
    end

  end
end
