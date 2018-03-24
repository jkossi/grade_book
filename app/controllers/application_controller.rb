class ApplicationController < ActionController::Base
  # layout :layout_by_resource


  private
  def layout_by_resource
    if devise_controller?
      'devise/cust'
    else
      'application'
    end
  end
end
