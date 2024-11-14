class DayWordResource < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

    field :id, as: :id
    field :word, as: :text
    field :active_until, as: :date_time
    field :active, as: :boolean

    action CreateDayWordAction
end
