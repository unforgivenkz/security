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
      @microposts = current_user.microposts.paginate(page: params[:page], :per_page => 30)
    end
  end
end
