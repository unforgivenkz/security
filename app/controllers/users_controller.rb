class UsersController < ApplicationController

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
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end



          