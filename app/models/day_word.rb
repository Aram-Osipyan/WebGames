class DayWord < ApplicationRecord
  def self.current_day_word
    DayWord.where('? < active_until', Time.current).order(:active_until).first
  end

  def self.ransackable_attributes(*)
    super + %w[day_word]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def active_from=(value)
    self.active_until = value
    self.active_until += 1.day

    save!
  end

  def active_from
    return nil unless active_until

    active_until - 1.day
  end

  def []=(attr_name, value)
    if attr_name.to_s == 'active_from'
      self.active_from = value
    else
      super # use ActiveRecord’s default write_attribute
    end
  end
end
