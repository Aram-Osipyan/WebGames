class BaseController < ApplicationController
  include TokenAuth

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  before_action :authenticate!
end
