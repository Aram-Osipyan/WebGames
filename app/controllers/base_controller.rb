class BaseController < ApplicationController
  include TokenAuth

  protect_from_forgery with: :null_session
  before_action :authenticate!
end
