class UserNotifier < ApplicationMailer
  default :from => 'wjkagzi@gmail.com'

  def welcome_email(user)
    @user = user
    mail(:to => @user.email, :subject => 'Thanks for signing up, #{@user}')
  end

  def clicked_button_email(user)
    @user = user
  end
end
