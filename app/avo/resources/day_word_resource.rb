class DayWordResource < Avo::BaseResource
  self.title = :word
  self.includes = []
  self.description = -> { "Текущее слово дня: #{DayWord.current_day_word&.word&.upcase}" }
  self.search_query = lambda {
    DayWord.where('word LIKE ?', "%#{params[:q]}%")
  }

  field :id, as: :id
  field :word, as: :text
  field :active_from, as: :date_time

  action CreateDayWordAction
end
