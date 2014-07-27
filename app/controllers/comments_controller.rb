class CommentsController < ApplicationController
  before_action :dbzi_user, only: [:create, :destroy]
  


   def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Коментарий успешно добавлен!"
      redirect_to '/room'
    else
      render 'oib/home'
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    if @comment.present?
      @comment.destroy
    end
    flash[:success] = "Коментарий удален!"
    redirect_to '/room'
  end


private

  def dbzi_user
    redirect_to(root_url) unless current_user.dbzi?
  end

  def comment_params
    params.require(:comment).permit(:content, :micropost_id)
  end

end
          