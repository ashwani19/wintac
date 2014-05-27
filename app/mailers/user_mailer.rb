class UserMailer < ActionMailer::Base
  default from: "xyz@example.com"
  
  def welcome_mail(user)
  	@user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
  def password_reset(user)
  	@user = user
  mail :to => user.email, :subject => "Password Reset"
  end
end
