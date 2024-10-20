array = [5, 3, 1, 7, 2, 1, 9, 3]

def sort(array)
  if array.length <= 1
    return array
  else
    mid = array.length / 2
    left = sort(array[0...mid])
    right = sort(array[mid..-1])

    merge(left, right)
  end
end

def merge(left, right)
  if left.empty?
    return right
  elsif right.empty?
    return left
  else
  temp_number = if left.first <= right.first
                  left.shift
                else
                  right.shift
                end
  [temp_number].concat(merge(left, right))
  end
end

puts array.join(", ")
puts ""
sorted = sort(array)
puts sorted.join(", ")
