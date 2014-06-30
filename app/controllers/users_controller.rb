class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @user = User.find(params[:id])
    url = URI.parse(request.original_url)
    if !@user.active
      @tok = CGI.parse(url.query)['token'].first
    end
    if @tok == @user.sign_token
      @user.update_attribute(:active, true)
      flash[:success] = "Процедура регистрации завершена."
      redirect_to '/home'
    end
  end

  def new
      @user = User.new
  end

  def create
  	@user = User.new (user_params)
  	@user.ip_address = request.remote_ip
 	  @user.resolv = Resolv.getname(request.remote_ip)
    @user.sign_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    @user.active = false
      if !simple_captcha_valid?
        flash[:error] = "Введен неверный код!"
        redirect_to '/signup'
      else
        if @user.save
          UserMailer.welcome_email(@user, request.original_url+"/#{@user.id}?token=#{@user.sign_token}").deliver
          flash[:success] = "#{@user.name}, на Ваш почтовый адрес направлено письмо для подтверждения регистрации"
          redirect_to '/home'
  	   else
  		    render 'new'
  	   end
      end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Профиль успешно изменен."
      redirect_to '/room'
    else  
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь удален."
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end


  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Пожалуйста, пройдите процедуру авторизации."
    end
    #redirect_to signin_url, notice: "Пожалуйста, пройдите процедуру авторизации." unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    #redirect_to(root_url) unless current_user?(@user) || current_user.admin?
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end



          