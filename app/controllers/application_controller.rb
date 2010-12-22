# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def logged_in
    if session[:access_token]
      unless session[:expires] > Time.new
        session[:next] = request.request_uri
        redirect_to root_url 
      end
    end
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
