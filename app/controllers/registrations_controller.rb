class RegistrationsController < Devise::RegistrationsController
  def create
    super {
      if @user.persisted?
        UserNotifier.welcome_email(@user).deliver_now
      end
    }
  end
end
