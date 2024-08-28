module Word
  class Validate
    def self.valid?(word)
      success = true

      return false unless success &&= word.size == 5

      connection = Faraday.new(url: 'https://api.gramdict.ru') do |conn|
        conn.response :json
      end

      path = "/v1/search/#{ERB::Util.url_encode(word)}?pagesize=210&pagenum=0&symbol=#{ERB::Util.url_encode('м,мо,ж,жо,с,со')}"

      response = connection.get(path)
      response.body['entries'].any? do |entry|
        next entry['lemma'].gsub(769.chr, '') == word
      end
    end

    def self.state(current_word, day_word)
      letter_hash = {}

      current_word.chars.each do |letter|
        letter_hash[letter] ||= 0
        letter_hash[letter] += 1
      end

      current_word.chars.each_with_index.map do |letter, index|
        next 3 if day_word[index] == letter

        if day_word.include?(letter)
          next 1 if (0..4).any? { |i| current_word[i] == day_word[i] && current_word[i] == letter } && day_word.count(letter) <= 1

          next 2
        end

        next 1
      end
    end
  end
end
