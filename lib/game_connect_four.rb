require_relative '../lib/board'
require_relative '../lib/vertex'

class Game

  def initialize(game = Board.new)
    @player_one = '➊'
    @player_two = '➁'
    @game = game
    @current_player = @player_one
    @win_status = nil
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

  def change_players
    @current_player == @player_one ? @current_player = @player_two : @current_player = @player_one
  end

  def horizontal_win_status
    i = 0
    reverse_vert = @game.vertices.reverse
    @game.vertices.reverse.each do |spot|
      if spot.occupied_color != 'open'
        if spot.name.end_with?('1', '2', '3')
          i += 1
          next
        elsif reverse_vert[i + 1].occupied_color == spot.occupied_color && reverse_vert[i + 2].occupied_color == spot.occupied_color && reverse_vert[i + 3].occupied_color == spot.occupied_color
          @win_status = @current_player
        end
      end
      i += 1
    end
  end

  def vertical_win_status
    i = 0
    vert = @game.vertices
    @game.vertices.each do |spot|
      if spot.occupied_color != 'open'
        if spot.name.start_with?('d', 'e', 'f')
          i += 1
          next
        elsif vert[i + 7].occupied_color == spot.occupied_color && vert[i + 14].occupied_color == spot.occupied_color && vert[i + 21].occupied_color == spot.occupied_color
          @win_status = @current_player
        end
      end
      i += 1
    end
  end
end

# game = Game.new
# game.start_game
# game.insert_piece
# game.insert_piece