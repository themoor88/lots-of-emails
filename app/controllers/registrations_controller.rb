class RegistrationsController < Devise::RegistrationsController
  def create
    super do
      UserNotifier.welcome_email(@user).deliver
    end
  end
end
