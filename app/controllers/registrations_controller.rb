class RegistrationsController < Devise::RegistrationsController
  def create
    super {
      if @user.persisted?
        UserNotifier.welcome_email(@user).deliver
      end
    }
  end
end
