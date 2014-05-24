class UserMailer < ActionMailer::Base
  default from: 'dbzi-portal@sberbank.kz'

   def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Добро пожаловать!')
  end
  
end
