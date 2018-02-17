def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def valid_move?(board, index)
  if index < 0 || index > board.length
    return false
  elsif board[index] == " " || board[index] == "" || board[index] == nil
    return true
  else
    return false
  end
end

def move(board, index, character = "X")
  board[index] = character
  return board
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets
  index = input_to_index(user_input)
  if !valid_move?(board, index)
    turn(board)
  end
  display_board(move(board, index))
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count +=1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def won?(board)
  i = 0
  empty = true
  while i < board.length
    if board[i] == "X" || board[i] == "O"
      empty = false
    end
    i += 1
  end
  if empty == true
    return false
  end
  WIN_COMBINATIONS.each do |win_arr|
    if position_taken?(board, win_arr[0]) && board[win_arr[0]] == board[win_arr[1]] && board[win_arr[1]] == board[win_arr[2]]
      return win_arr
    end
  end
  return false
end

def full?(board)
  if board.any? { |e| e == " " }
    return false
  else
    return true
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
end


def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    win_arr = won?(board)
    return board[win_arr[0]]
  end
end

def play(board)
  turn_counter = 0
  while turn_counter < 9
    turn(board)
    turn_counter += 1
  end
end
