alphabet = ('a'..'z').to_a
vowels = ['a', 'e', 'i', 'o', 'u', 'y']
hash = {}

vowels.each { |v| hash[v] = alphabet.index(v) + 1 }

puts hash