class UserMailer < ActionMailer::Base
  default from: 'dbzi-portal@sberbank.kz'

   def welcome_email(user, login_url)
    @user = user
    @url  = login_url
    mail(to: @user.email, subject: 'Добро пожаловать!')
  end
  
end
