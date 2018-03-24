module Api::V1
  class BaseController < ApplicationController
    # ACTION CONTROLLER FILTERS
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!


    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :gender, :phone, :role_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :gender, :phone, :role_id])
    end
  end
end

