class BaseController < ApplicationController
  include TokenAuth

  before_action :authenticate!
end
