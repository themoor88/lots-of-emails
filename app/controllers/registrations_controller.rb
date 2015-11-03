class RegistrationsController < Devise::RegistrationsController
  include Emailable

  def create
    super {
      if @user.persisted?
        send_confirmation_email(@patient)
      end
    }
  end
end

