require "pry"

class Board
  attr_reader :matrix, :table

  def initialize(matrix:)
    @matrix = matrix
    @table = convert_matrix_to_table
  end

  def convert_matrix_to_table
    matrix.map do |row|
      row.map do |cell|
        Cell.new(number: cell)
      end
    end
  end

  def play_number(number:)
    found_cell = cells.find do |cell|
      cell.number == number
    end

    if found_cell
      found_cell.mark!
    end
  end

  def winner?
    found_winning_row = table.find do |row|
      row.all? { |cell| cell.marked? }
    end

    return found_winning_row if found_winning_row

    found_winning_column = table.transpose.find do |col|
      col.all? { |cell| cell.marked? }
    end

    return found_winning_column if found_winning_column

    nil
  end

  def unmarked_numbers
    cells.select do |cell|
      cell.unmarked?
    end.map(&:number)
  end

  private

  def cells
    table.flatten
  end
end

class Cell
  attr_reader :number

  def initialize(number:)
    @number = number
    @marked = false
  end

  def marked?
    @marked
  end

  def unmarked?
    !marked?
  end

  def mark!
    @marked = true
  end
end

def board_inputs
  File.read("bingo.txt").split("\n\n")[1..-1]
end

# input
# => " 5 43 13 47 93\n25 78 64 56 10\n75 90 50 72 14\n 9 29 58 79 62\n69 66 88 35 16"
# output
# array of arrays?
def convert_board_input_to_matrix(board_input)
  board_input.split("\n").map do |row|
    row.strip.split(/\s+/).map(&:to_i)
  end
end

def boards
  @boards ||= board_inputs.map do |board_input|
    Board.new(matrix: convert_board_input_to_matrix(board_input))
  end
end

def announced_numbers
  File.read("bingo.txt").split("\n\n")[0].split(",").map { |s| s.to_i }
end

def play_number(number:)
  boards.each do |board|
    board.play_number(number: number)
  end
end

def any_board_winners?
  boards.find do |board|
    board.winner?
  end
end

announced_numbers.each do |number|
  play_number(number: number)

  if any_board_winners?
    puts "found a board winner"

    puts any_board_winners?.unmarked_numbers.sum * number

    return
  end
end
