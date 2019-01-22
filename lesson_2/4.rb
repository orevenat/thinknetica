alphabet = Hash[(:a..:z).zip(1..26)]

vowels = %i[a e i o u]

result = alphabet.select { |letter| vowels.include?(letter) }

puts result
