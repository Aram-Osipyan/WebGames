# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super do |admin|
      Current.admin = admin
    end
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    super do |admin|
      Current.admin = admin
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
