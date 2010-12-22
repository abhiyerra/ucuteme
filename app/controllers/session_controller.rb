require 'net/http'
require 'net/https'
require 'uri'

class SessionController < ApplicationController
  def create
    request_host = Rails.env.eql?('development') ? 'localhost:3000' : 'ucuteme.com'
    access_token_hash = MiniFB.oauth_access_token(FB_APP_ID, "http://#{request_host}/sessions/create", FB_SECRET, params[:code])
    @access_token = access_token_hash["access_token"]

    session[:access_token] = @access_token

    redirect_uri = url_for(:controller => "cute", :action => "index")
    redirect_to redirect_uri
  end

  def destroy
    session[:access_token] = nil
    session[:expires] = nil
    session[:uid] = nil

    redirect_to :controller => 'welcome', :action => 'index'
  end

  def info
    render :text => session[:uid]
  end
end
