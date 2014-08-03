class OibController < ApplicationController
  def home
  end

  def news
  end

  def structure
    @department0s = Department.where('dep LIKE ?', 0)
    @department1s = Department.where('dep LIKE ?', 1)
    @department2s = Department.where('dep LIKE ?', 2)
    @department3s = Department.where('dep LIKE ?', 3)
    @department4s = Department.where('dep LIKE ?', 4)

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
