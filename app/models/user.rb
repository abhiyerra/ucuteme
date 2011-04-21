class User < ActiveRecord::Base

  def add_activity(to, message)
    activity = Activity.create(:to => to, :message => message)


  end
end
