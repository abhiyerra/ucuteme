class WelcomeController < ApplicationController
  def index
    @oauth_url = MiniFB.oauth_url(FB_APP_ID, # your Facebook App ID (NOT API_KEY)
                                  "http://ucuteme.com/session/create", # redirect url
                                  :scope => MiniFB.scopes.join(",")) # This asks for all permissions
  end

  def invite
  end
end
