require 'net/http'
require 'net/https'
require 'uri'

class SessionController < ApplicationController
  def login
    url = "https://graph.facebook.com/oauth/authorize?client_id=#{FB_APP_ID}&redirect_uri=http://ucuteme.com/session/create&scope=user_about_me,friends_about_me,user_activities,friends_activities,user_birthday,friends_birthday,user_education_history,friends_education_history,user_events,friends_events,user_groups,friends_groups,user_interests,friends_interests,user_likes,friends_likes,user_location,friends_location,user_notes,friends_notes,user_online_presence,friends_online_presence,user_photo_video_tags,friends_photo_video_tags,user_photos,friends_photos,user_relationships,friends_relationships,user_religion_politics,friends_religion_politics,user_status,friends_status,user_videos,friends_videos,user_website,friends_website,user_work_history,friends_work_history,read_friendlists,read_stream"

    redirect_to url
  end

  def create
    http = Net::HTTP.new('graph.facebook.com', 443)
    http.use_ssl = true
    path = "/oauth/access_token?client_id=#{FB_APP_ID}&redirect_uri=http://ucuteme.com/session/create&client_secret=#{FB_SECRET}&code=#{params[:code]}"

    resp, data = http.get(path, nil)
    access_token_hash = {}

    data.split('&').map {|x| x.split('=') }.each do |k,v|
      access_token_hash[k] = v
    end

    session[:access_token] = access_token_hash['access_token']
    session[:expires] = Time.at(access_token_hash["expires"].to_f + Time.new.to_f)

    # Find out the user information.
    http = Net::HTTP.new('graph.facebook.com', 443)
    http.use_ssl = true
    path = "/me?access_token=#{session[:access_token]}"
    resp, data = http.get(path, nil)
    user_info = JSON.parse(data)

    session[:uid] = user_info['id']
    RedisDB.set "name:#{user_info['id']}", user_info['name']
    RedisDB.set "link:#{user_info['id']}", user_info['link']
    RedisDB.set "gender:#{user_info['id']}", user_info['gender']


    redirect_uri = session[:next] || url_for(:controller => "cute", :action => "index")
    session[:next] = nil
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
