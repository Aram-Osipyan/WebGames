class DayWordPolicy < ApplicationPolicy
    attr_reader :user, :post
  
    def initialize(user, post)
      @user = user
      @post = post
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  
    def create?
      false
    end

    def index?
      true
    end

    def act_on?
      true
    end

    def update?
      true
    end

    def show?
      true
    end
end