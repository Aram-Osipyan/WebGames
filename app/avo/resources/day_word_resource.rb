class DayWordResource < Avo::BaseResource
  self.title  = :word
  self.includes = []
  self.description = -> { "Текущее слово дня: #{DayWord.current_day_word&.word&.upcase}" }
  self.search_query = -> do
    DayWord.where("word LIKE ?", "%#{params[:q]}%")
  end



  field :id, as: :id
  field :word, as: :text
  field :active_until, as: :date_time

  action CreateDayWordAction
end
