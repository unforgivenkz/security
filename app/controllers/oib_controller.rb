class OibController < ApplicationController
  def home
  end

  def news
  end

  def structure
    @department0s = Department.where('dep = 0')
    @department1s = Department.where('dep = 1')
    @department2s = Department.where('dep = 2')
    @department3s = Department.where('dep = 3')
    @department4s = Department.where('dep = 4')

  end

  def help
    @knowbases = Knowbase.all
  end

  def room
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 30)
    end

    
  end

end
