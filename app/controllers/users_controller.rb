class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
      @user = User.new
  end

  def create
  	@user = User.new (user_params)
  	@user.ip_address = request.remote_ip
  	@user.resolv = Resolv.getname(request.remote_ip)
  	if @user.save
      UserMailer.welcome_email(@user).deliver
      flash[:success] = "Вы успешно прошли процедуру регистрации на портале ДБиЗИ!"
      redirect_to @user
  	else
  		render 'new'
  	end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
