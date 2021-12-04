def binary_numbers
  @binary_numbers = File.read("binary_numbers.txt").split("\n").map do |s|
    s.split(" ")
  end.map do |a|
    a.first.split("")
  end.map do |a|
    a.map(&:to_i)
  end
end

def oxygen_filter(nested_arrays, index)
  one = 0
  zero = 0

  nested_arrays.each do |a|
    if a[index] == 1
      one += 1
    elsif a[index] == 0
      zero += 1
    end
  end

  if one >= zero
    nested_arrays.select { |a| a[index] == 1 }
  elsif zero > one
    nested_arrays.select { |a| a[index] == 0 }
  end
end

def oxygen_generator_rating
  columns = binary_numbers[0].size
  output = binary_numbers

  columns.times do |column|
    output = oxygen_filter(output, column)
  end

  output.join('').to_i(2)
end

def co2_filter(nested_arrays, index)
  one = 0
  zero = 0

  nested_arrays.each do |a|
    if a[index] == 1
      one += 1
    elsif a[index] == 0
      zero += 1
    end
  end

  if one < zero
    nested_arrays.select { |a| a[index] == 1 }
  elsif zero <= one
    nested_arrays.select { |a| a[index] == 0 }
  end
end

def co2_scrubber_rating
  columns = binary_numbers[0].size
  output = binary_numbers

  columns.times do |column|
    if output.size == 1
      break
    end
    output = co2_filter(output, column)
  end

  output.join('').to_i(2)
end

puts oxygen_generator_rating * co2_scrubber_rating
