class CreateDayWordAction < Avo::BaseAction
  self.name = "Create Day Word Action"
  self.standalone = true
  self.visible = -> do
    view == :index
  end

  field :word, as: :text, required: true

  def handle(fields:, current_user:, resource:, **args)

    return error('Слово должно состоять из 5 букв') if fields[:word].length != 5
    DayWord.create!(word:fields[:word])

    succeed 'Word created successfully'
  end
end
