class CreateDayWordAction < Avo::BaseAction
  self.name = 'Create Day Word Action'
  self.standalone = true
  self.visible = lambda {
    view == :index
  }

  field :word, as: :text, required: true
  field :active_until, as: :date_time, required: true

  def handle(fields:, current_user:, resource:, **_args)
    return error('Слово должно состоять из 5 букв') if fields[:word].length != 5
    return error('Такого слова не существует или этого слова нет в словаре') unless Word::Validate.valid?(fields[:word])

    DayWord.order(:active_until).last

    DayWord.create!(word: fields[:word], active_until: fields[:active_until])

    succeed 'Word created successfully'
  end
end
