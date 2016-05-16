require_relative 'board'
require_relative 'player'

class Game

  attr_reader :board, :player, :starting_position, :current_position

  def initialize(board, player)
    @board = board
    @player = player
    @starting_position = board.start
    @current_position = board.start
  end

  def play
    until @player.current_position == @board.end
      @board.render
      #player to update current position
      prev_pos = @player.current_position
      next_move = @player.get_move

      @board.update(next_move, prev_pos)
      @player.update_current_position(next_move)
      sleep(1)
    end
    @board.render
    puts "yay you win"
  end
end


if __FILE__ == $PROGRAM_NAME

  board = Board.new("maze1.txt")
  player = Player.new(board)
  game = Game.new(board, player)
  game.play
end
