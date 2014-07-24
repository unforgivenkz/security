class CommentsController < ApplicationController
  #before_action :dbzi_user, only: [:create, :destroy]
  


   def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.micropost_id = 22
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to '/room'
    else
      render 'oib/home'
    end
  end


  def destroy
  end


private

  def dbzi_user
    redirect_to(root_url) unless current_user.dbzi?
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
          