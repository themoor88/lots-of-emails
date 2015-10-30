class RegistrationsController < Devise::RegistrationsController
  def create
    super {
      UserNotifier.welcome_email(@user).deliver
    }
  end
end
