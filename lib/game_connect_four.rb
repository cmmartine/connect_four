require_relative '../lib/board'
require_relative '../lib/vertex'
require 'colorize'

class Game

  def initialize(game = Board.new)
    @player_one = '⚫'.blue
    @player_two = '⚫'.red
    @game = game
    @current_player = @player_one
    @win_status = nil
    @start_game_instructions = nil
  end

  def start_game
    instructions = "Welcome to Connect Four! \nTo make a move, choose a column number 1-7 to play your piece.\n\n"

    return unless @start_game_instructions.nil?

    @game.create_board
    puts instructions
    display_board
    @start_game_instructions = 1
  end

  def game_loop
    start_game
    puts "Player #{@current_player}'s turn: "
    insert_piece
    display_board
    check_win_status

    if @win_status == @current_player
      display_board
      puts "Congratulations #{@current_player} you have won!"
      reset_board?
    else
      change_players
      game_loop
    end
  end

  def insert_piece(choice = player_choice, column = @game.columns[choice - 1])

    unless @game.vertices[column.last].occupied_color != 'open'
    end_spots = [6, 13, 20, 27, 34, 41]
      column.each do |spot|
        if @game.vertices[spot].occupied_color == 'open'
          @game.vertices[spot].occupied_color = @current_player
          if end_spots.include?(spot)
            @game.board[spot] = "|#{@current_player}\n"
          else
            @game.board[spot] = "|#{@current_player}"
          end
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

  def check_win_status
    horizontal_win_status
    vertical_win_status
    top_left_bot_right_diagonal_win
    top_right_bot_left_diagonal_win
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

  def top_left_bot_right_diagonal_win
    i = 0
    vert = @game.vertices
    @game.vertices.each do |spot|
      if spot.occupied_color != 'open'
        if spot.name.start_with?('d', 'e', 'f') || spot.name.end_with?('4', '5', '6')
          i += 1
          next
        elsif vert[i + 8].occupied_color == spot.occupied_color && vert[i + 16].occupied_color == spot.occupied_color && vert[i + 24].occupied_color == spot.occupied_color
          @win_status = @current_player
        end
      end
      i += 1
    end
  end

  def top_right_bot_left_diagonal_win
    i = 0
    vert = @game.vertices
    @game.vertices.each do |spot|
      if spot.occupied_color != 'open'
        if spot.name.start_with?('d', 'e', 'f') || spot.name.end_with?('1', '2', '3')
          i += 1
          next
        elsif vert[i + 6].occupied_color == spot.occupied_color && vert[i + 12].occupied_color == spot.occupied_color && vert[i + 18].occupied_color == spot.occupied_color
          @win_status = @current_player
        end
      end
      i += 1
    end
  end

  def display_board
    puts @game.board_header.join('')
    puts @game.board.join('')
    puts "\n\n"
  end

  def reset_board?
    puts "Would you like to play again? (y/n):\n"
    choice = gets.chomp.downcase
    if choice == 'y' || choice == 'yes'
      @game = Board.new
      @current_player = @player_one
      @win_status = nil
      @start_game_instructions = nil
      game_loop
    end
  end
end

 game = Game.new
 game.game_loop
