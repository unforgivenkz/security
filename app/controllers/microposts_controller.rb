class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments.paginate(page: params[:page], :per_page => 30)
    @userpost = @micropost.user
  end  

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Сообщение опубликовано!"
      redirect_to '/room'
    else
      @feed_items = []
      render 'oib/room'
    end
  end


  def destroy
    @micropost.destroy
    flash[:success] = "Сообщение удалено!"
    redirect_to '/room'
  end


private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end



          