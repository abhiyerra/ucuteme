class CutesController < ApplicationController
  layout "application", :except => [:friend_boxes, :login, :logout]

  before_filter :logged_in

  def index
    http = Net::HTTP.new('graph.facebook.com', 443)
    http.use_ssl = true
    path = "/me/friends?access_token=#{session[:access_token]}"
    resp, data = http.get(path, nil)

    @friends = JSON.parse(data)['data']
  end

  def events
  end

  def new
    Cute.cute(session[:uid], params[:uid])

    # Add activity for cuter.
    User.add_activity session[:uid], "You cuted #{params[:name]}."
    # Add activity to cutee.
    User.add_activity params[:uid], "Someone cuted you."

    if Cute.cuted?(params[:uid], session[:uid])
      render :inline => "<%= cuted_back_link(params[:uid], params[:name]) -%>", :layout => nil
    else
      render :inline => "<%= unsure_link(params[:uid], params[:name]) -%>", :layout => nil
    end
  end

  def destroy
    Cute.uncute(session[:uid], params[:uid])

    # Add activity for uncuter.
    User.add_activity session[:uid], "You uncuted #{params[:name]}."
    # Add activity to uncutee.
    User.add_activity params[:uid], "Someone uncuted you."

    render :inline => "<%= cute_link(params[:uid], params[:name]) -%>", :layout => nil
  end

end
