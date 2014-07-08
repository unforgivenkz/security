class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def index
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Сообщение опубликовано!"
      redirect_to '/room'
    else
      render 'oib/room'
    end
  end


  def destroy
  end


private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

end



          