class AuthenticationLine < ApplicationRecord
  attribute :code, default: -> { SecureRandom.hex }
  belongs_to :user

  def self.get_active(user_id)
    active = AuthenticationLine.find_by(user_id: user_id, active: true)

    if active.nil? || active.active_until < Time.current
      active&.update!(active: false)

      active = AuthenticationLine.create(user_id: user_id, active: true, active_until: 1.hour.from_now)
    end

    active
  end
end
