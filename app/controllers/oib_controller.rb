class OibController < ApplicationController
  def home
  end

  def news
  end

  def structure
  end

  def help
  end

  def room
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 30)
    end

    
  end

end
