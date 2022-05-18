vowels_list = ["a", "e", "i", "o", "u"]
letters_array = ("a".."z").to_a
num = 1
letters_hash = {}
vowels_hash = {}

letters_array.each do |letter|
  letters_hash[letter] = num
  num += 1
end

letters_hash.each {|key, value|
  vowels_list.each do |vowel|
    if key == vowel
      vowels_hash[key] = value
    end
  end
}
