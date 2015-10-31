class UserNotifier < ApplicationMailer
  default :from => 'wjkagzi@gmail.com'

  def welcome_email(user)
    mail(:to => user.email, :subject => 'Thanks for signing up, #{@user}')
  end
end
