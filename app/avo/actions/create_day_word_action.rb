class CreateDayWordAction < Avo::BaseAction
  self.name = "Create Day Word Action"
  self.standalone = true
  self.visible = -> do
    view == :index
  end

  field :word, as: :text, required: true
  field :active_until, as: :date_time, required: true, default: (DayWord.where('active_until is not null').order(:active_until).last.active_until + 1.day).end_of_day

  def handle(fields:, current_user:, resource:, **args)

    return error('Слово должно состоять из 5 букв') if fields[:word].length != 5
    return error('Такого слова не существует или этого слова нет в словаре') unless Word::Validate.valid?(fields[:word])

    last_day_word = DayWord.order(:active_until).last
    
    DayWord.create!(word: fields[:word], active_until: fields[:active_until])

    succeed 'Word created successfully'
  end
end
