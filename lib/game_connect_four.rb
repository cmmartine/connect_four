require_relative '../lib/board'
require_relative '../lib/vertex'

class Game

  def initialize(game = Board.new)
    @player_one = '➊'
    @player_two = '➁'
    @game = game
    @current_player = @player_one
  end

  def start_game
    @game.create_board
  end

  def insert_piece(choice = player_choice, column = @game.columns[choice - 1])

    unless @game.vertices[column.last].occupied_color != 'open'
      column.each do |spot|
        if @game.vertices[spot].occupied_color == 'open'
          @game.vertices[spot].occupied_color = @current_player
          break
        end
      end
    else
      puts 'Please choose a different column!'
      insert_piece
    end
  end

  def player_choice
    puts "Player: #{@current_player}, choose a column to go: "
    choice = gets.chomp.to_i
    if choice >= 1 && choice <= 7
      choice
    else
      puts "Choose a number from 1 to 7.\n"
      player_choice
    end
  end
end

# game = Game.new
# game.start_game
# game.insert_piece
# game.insert_piece