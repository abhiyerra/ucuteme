# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def in_fbml?
    !params[:fb_sig_in_new_facebook].nil?
  end
end
