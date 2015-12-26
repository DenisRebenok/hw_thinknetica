# alphabet = ('a'..'z')
vowels = ['a', 'e', 'i', 'o', 'u', 'y']

hash = {}
# vowels.each { |v| hash[v] = alphabet.index(v) + 1 }
('a'..'z').each_with_index { |letter, number| hash[letter] = number+1 if vowels.include?(letter) }

p hash