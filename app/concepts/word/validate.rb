module Word
  class Validate

    def initialize(word)
      @word = word
    end

    def valid?
      success = true

      return false unless success &&= @word.size == 5

      connection = Faraday.new(url: 'https://api.gramdict.ru') do |conn|
        conn.response :json
      end

      path = "/v1/search/#{ERB::Util.url_encode(@word)}?pagesize=210&pagenum=0&symbol=#{ERB::Util.url_encode('м,мо,ж,жо,с,со')}"

      response = connection.get(path)
      response.body['entries'].any? { |entry| entry['lemma'].gsub!(769.chr, '') == @word } # remove stress sign
    end
  end
end
