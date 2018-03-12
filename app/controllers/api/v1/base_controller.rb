class Api::V1::BaseController < ApplicationController
  # ACTION CONTROLLER FILTERS
  before_action :authenticate_user!
end
