class QuizUserAnswerPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope < Scope
    def resolve
      # Only show quiz user answers if admin is managing quiz game
      if user&.game == 'quiz'
        scope.joins(quiz_game: :user).where(users: { game: 'quiz' })
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

    record.quiz_game&.user&.game == 'quiz'
  end
end
