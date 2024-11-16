class DayWord < ApplicationRecord
    def self.current_day_word
        DayWord.where('? < active_until', Time.current).order(:active_until).first
    end

    def self.ransackable_attributes(*)
        super + %w(day_word)
    end

    def self.ransackable_associations(auth_object = nil)
        []
    end
end
