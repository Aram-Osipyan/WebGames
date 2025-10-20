class ApplicationService
  include ActiveModel::Validations
  include Dry::Monads[:result]
  extend Dry::Initializer
  extend Memoist

  def self.perform(...)
    new(...).perform
  end

  def perform
    raise NotImplementedError
  end

  # alias (instead we will have current method behavior)
  def call = perform

  class << self
    alias call perform
  end
end
