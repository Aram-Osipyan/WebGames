class QuizQuestionPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope < Scope
    def resolve
      # Only show quiz questions if admin is managing quiz game
      if user&.game == 'quiz'
        scope.all
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
    user&.game == 'quiz'
  end
end
