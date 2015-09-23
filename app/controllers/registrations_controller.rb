class RegistrationsController < Devise::RegistrationsController
  def create
    super do
      UserNotifier.welcome_email(@user).deliver
      redirect_to(@user, :notice => 'User created')
    end
  end
end
