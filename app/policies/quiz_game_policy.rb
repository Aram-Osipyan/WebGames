class QuizGamePolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope < Scope
    def resolve
      # Only show quiz games for users with the same game as the current admin
      if user&.game == 'quiz'
        scope.joins(:user).where(users: { game: 'quiz' })
      else
        scope.none
      end
    end
  end

  def create?
    user&.game == 'quiz'
  end

  def index?
    user&.game == 'quiz'
  end

  def act_on?
    user&.game == 'quiz'
  end

  def destroy?
    user&.game == 'quiz'
  end

  def update?
    user&.game == 'quiz'
  end

  def show?
    return false unless user&.game == 'quiz'

    record.user&.game == 'quiz'
  end
end
