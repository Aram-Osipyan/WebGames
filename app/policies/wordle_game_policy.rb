class WordleGamePolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope < Scope
    def resolve
      # Only show wordle games for users with the same game as the current admin
      if user&.game == 'wordle'
        scope.joins(:user).where(users: { game: 'wordle' })
      else
        scope.none
      end
    end
  end

  def create?
    user&.game == 'wordle'
  end

  def index?
    user&.game == 'wordle'
  end

  def act_on?
    user&.game == 'wordle'
  end

  def destroy?
    user&.game == 'wordle'
  end

  def update?
    user&.game == 'wordle'
  end

  def show?
    return false unless user&.game == 'wordle'

    record.user&.game == 'wordle'
  end
end
