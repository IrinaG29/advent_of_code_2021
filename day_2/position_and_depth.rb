#Question: What do you get if you multiply your final horizontal position by your final depth?

def commands
  @commands = File.read("commands.txt").split("\n").map { |s| s.split(" ") }.map { |a| [a[0], a[1].to_i] }
end

def position_and_depth
  horizontal_position = 0
  depth = 0

  commands.each do |a|
    if a[0] == "forward"
      horizontal_position += a[1]
    elsif a[0] == "down"
      depth += a[1]
    elsif a[0] == "up"
      depth -= a[1]
    end
  end

  final_position = horizontal_position * depth
end

puts position_and_depth
