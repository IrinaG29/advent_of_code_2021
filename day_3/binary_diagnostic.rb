def binary_numbers
  @binary_numbers = File.read("binary_numbers.txt").split("\n").map do |s|
    s.split(" ")
  end.map do |a|
    a.first.split("")
  end.map do |a|
    a.map(&:to_i)
  end
end

def power_consumption
  gamma_rate = []
  epsilon_rate = []

  columns = binary_numbers[0].size

  columns.times do |column|
    one = 0
    zero = 0
    binary_numbers.each do |a|
      if a[column] == 1
        one += 1
      elsif a[column] == 0
        zero += 1
      end
    end

    if one > zero
      gamma_rate << 1
      epsilon_rate << 0
    elsif zero > one
      gamma_rate << 0
      epsilon_rate << 1
    end
  end

  gamma_rate.join('').to_i(2) * epsilon_rate.join('').to_i(2)
end

puts power_consumption
