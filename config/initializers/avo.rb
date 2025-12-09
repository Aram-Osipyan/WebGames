# config/initializers/avo.rb
Avo.configure do |config|
  # puts config.to_h
  config.current_user_method = :current_admin
end
