def lines
  nested_arrays = File.read("lines_of_vents.txt").split("\n").map do |s|
    s.split(" -> ")
  end.map do |a|
    a.map { |s| s.split(",") }
  end

  to_integers = nested_arrays.map { |a_1| a_1.map { |a_2| a_2.map { |s| s.to_i }}}
  to_integers.map { |a_1| a_1.map { |a_2| { x: a_2[0], y: a_2[1] }}}
end

def horizontal_vertical_lines
  lines.select { |a| a[0][:x] == a[1][:x] || a[0][:y] == a[1][:y] }
end

def max_x
  horizontal_vertical_lines.select { |a| a[0][:x] == a[1][:x] || a[0][:y] == a[1][:y] }.map { |a| [a[0][:x], a[1][:x]] }.flatten.max
end

def max_y
  horizontal_vertical_lines.select { |a| a[0][:x] == a[1][:x] || a[0][:y] == a[1][:y] }.map { |a| [a[0][:y], a[1][:y]] }.flatten.max
end

def grid
  @grid ||= (max_y + 1).times.map do |a|
    (max_x + 1).times.map { 0 }
  end
end

def direction_of_line(line)
  if line[0][:x] == line[1][:x]
    :vertical
  else
    :horizontal
  end
end

def draw_horizontal_line(line)
  y = line[0][:y]
  min_x = [line[0][:x], line[1][:x]].min
  max_x = [line[0][:x], line[1][:x]].max

  grid[y].each_with_index do |item, index|
    if index >= min_x && index <= max_x
      grid[y][index] = grid[y][index] + 1
    end
  end
end

def draw_vertical_line(line)
  x = line[0][:x]
  min_y = [line[0][:y], line[1][:y]].min
  max_y = [line[0][:y], line[1][:y]].max

  grid.each_with_index do |row, index|
    if index >= min_y && index <= max_y
      grid[index][x] = grid[index][x] + 1
    end
  end
end

horizontal_vertical_lines.each do |line|
  case direction_of_line(line)
  when :horizontal
    draw_horizontal_line(line)
  when :vertical
    draw_vertical_line(line)
  else
    fail
  end
end

r = grid.map do |row|
  row.count do |cell|
    cell > 1
  end
end

puts r.sum
