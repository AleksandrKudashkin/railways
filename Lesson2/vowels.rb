result = Hash.new
vowels = ['a', 'e', 'i', 'o', 'u', 'y']
('a'..'z').each_with_index { |val, index|
  result[val.to_sym] = index + 1 if vowels.include?(val)
}

puts result