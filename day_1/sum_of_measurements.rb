#Question: How many sums are larger than the previous sum (three-measurement sliding window)?

def measurements
  @measurements = File.read("measurements.txt").split("\n").map { |s| s.to_i }
end

def sum_of_measurements
  measurements.each_cons(3).map do |n|
    n.sum
  end
end

def larger_measurements
  list_larger_measurements = []
  previous_n = nil

  sum_of_measurements.each do |n|
    if previous_n == nil
      previous_n = n
    elsif n < previous_n
      previous_n = n
    elsif n > previous_n
      list_larger_measurements << n
      previous_n = n
    end
  end

  list_larger_measurements.length
end

puts larger_measurements
