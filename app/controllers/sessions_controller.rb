class SessionsController < ApplicationController
  def new
  end

  def create
  user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    if user.active
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Необходимо подтверждение регистрации'
      render 'new'
    end
  else
    flash.now[:error] = 'Неверно указано имя пользователя и/или пароль' # Not quite right!
    render 'new'
  end
  end

  def destroy
  	sign_out
    redirect_to root_url
  end
end
