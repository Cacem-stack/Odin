def fibs(n)
  arr = [0, 1]
  index = 1
  nmod = n - 2
  nmod.times do
    arr << arr[index] + arr[index - 1]
    index += 1
  end
  puts arr.join(", ")
end

def fibs_rec(n, arr = [0, 1])
  if n <= 2
    return arr
  else
    arr << arr[-1] + arr[-2]
    fibs_rec(n - 1, arr)
  end
  arr.join(", ")
end

n = "Pending Integer value"
puts "Enter an Integer"
n = gets.chomp.to_i until n.class == Integer
puts fibs_rec(n)
