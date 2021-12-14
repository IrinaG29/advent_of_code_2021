require "pry"

nested_arrays = File.read("lines_of_vents.txt").split("\n").map do |s|
  s.split(" -> ")
end.map do |a|
  a.map { |s| s.split(",") }
end

to_integers = nested_arrays.map { |a_1| a_1.map { |a_2| a_2.map { |s| s.to_i }}}
to_hash = to_integers.map { |a_1| a_1.map { |a_2| { x: a_2[0], y: a_2[1] }}}

def horizontal_vertical_lines(to_hash)
  to_hash.select { |a| a[0][:x] == a[1][:x] || a[0][:y] == a[1][:y] }
end

def overlapping_lines
  grid = []
  
end
binding.pry
