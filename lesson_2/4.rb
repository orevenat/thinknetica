alphabet = (:a..:z).zip(1..27).to_h

vowels = %i[a e i o u]

result = alphabet.select { |letter| vowels.include?(letter) }

puts result
