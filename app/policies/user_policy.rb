class UserPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  class Scope < Scope
    def resolve
      # Only show users with the same game as the current admin
      if user&.game.present?
        scope.where(game: user.game)
      else
        scope.none
      end
    end
  end

  def create?
    false
  end

  def index?
    user&.game.present?
  end

  def act_on?
    true
  end

  def destroy?
    false
  end

  def update?
    false
  end

  def show?
    return false unless user&.game.present?

    post&.game == user.game
  end
end
