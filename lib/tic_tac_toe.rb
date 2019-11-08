require "pry"
class TicTacToe
  
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS=[
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    ]
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
  
  def input_to_index(user_input)
    index = user_input.to_i-1
  end

  def move(index, token="X")
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"? true : false
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8)
  end

  def turn_count
    @board.count do |item|
      item == "X" || item == "O"
    end
  end
  
  def current_player
    turn_count.even? ? "X" : "O"
  end

  def turn
    puts "Please enter an input 1-9"
    user_input = gets.chomp.to_i
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_combo_square_1 = win_combination[0]
      win_combo_square_2 = win_combination[1]
      win_combo_square_3 = win_combination[2]
      position_1 = @board[win_combo_square_1]
      position_2 = @board[win_combo_square_2]
      position_3 = @board[win_combo_square_3]
      if position_1 == position_2 && position_2 == position_3 && position_1 != " "
        return win_combination
      end
    end
    false
  end  

  def full?
    turn_count == 9
  end  

  def draw?
    if !won? && full?
      true
    elsif !won? && !full?
      false
    elsif won?
      false
    else 
      false
    end
  end

  def over?
    draw? || won?
  end

  def winner
    if won?
      @board[won?[0]]
    else
      nil
    end
  end

end