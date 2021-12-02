#Question: How many measurements are larger than the previous measurement?

def measurements
  @measurements = File.read("measurements.txt").split("\n").map { |s| s.to_i }
end

def larger_measurements
  list_larger_measurements = []

  previous_n = nil
  measurements.each do |n|
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
