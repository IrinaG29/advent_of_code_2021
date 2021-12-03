def commands
  @commands = File.read("commands.txt").split("\n").map { |s| s.split(" ") }.map { |a| [a[0], a[1].to_i] }
end

def position_depth_aim
  horizontal_position = 0
  depth = 0
  aim = 0

  commands.each do |a|
    if a[0] == "forward"
      (horizontal_position += a[1])
      (depth += (aim * a[1]))
    elsif a[0] == "down"
      aim += a[1]
    elsif a[0] == "up"
      aim -= a[1]
    end
  end

  final_position = horizontal_position * depth
end

puts position_depth_aim
