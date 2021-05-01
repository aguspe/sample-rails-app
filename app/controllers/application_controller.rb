class ApplicationController < ActionController::Base
  include SessionsHelper

  def require_log_in
    unless logged_in?
      store_location
      flash[:danger] = 'Plase log in'
      redirect_to login_url
    end
  end
end
