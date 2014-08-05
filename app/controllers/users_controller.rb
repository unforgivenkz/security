class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], :per_page => 30)
  end


  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 30)
    url = URI.parse(request.original_url)
    if !@user.active
      @tok = CGI.parse(url.query)['token'].first
    end
    if @tok == @user.sign_token
      @user.update_attribute(:active, true)


      @userfol = User.where('dbzi = ?', true)

        @userfol.each { 
          |followed| followed.follow!(@user)
        }

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
    @user.ip_address = request.remote_ip
    @user.resolv = Resolv.getname(request.remote_ip)

    if current_user.admin? && !current_user?(@user)
      @up_param = admin_params_update
    else
      @up_param = user_params_update
    end  


    if !(@user.dbzi == !@up_param[:dbzi].to_i.zero?) && !(@user.id == current_user.id)
      if !@up_param[:dbzi].to_i.zero?
        users = (@user.blank? ? User.all : User.find(:all, :conditions => ["id != ?", @user.id]))
        followed_users = users
        followed_users.each { 
          |followed| @user.follow!(followed) if !@user.following?(followed)
        }
      else
        followed_users = @user.followed_users
        followed_users.each { |followed| @user.unfollow!(followed) }
      end  
    end  


    if @user.update_attributes(@up_param)
      flash[:success] = "Профиль пользователя #{@user.name} успешно изменен."
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



  def following
    @title = "Подписки"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Подписчики"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def user_params_update
    params.require(:user).permit(:name, :password, :password_confirmation, :avatar)
  end

  def admin_params_update
    params.require(:user).permit(:password, :password_confirmation, :admin, :dbzi)
  end


  # Before filters

  #def signed_in_user
  #  unless signed_in?
  #    store_location
  #    redirect_to signin_url, notice: "Пожалуйста, пройдите процедуру авторизации."
  #  end
  #end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) || current_user.admin?
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end



          