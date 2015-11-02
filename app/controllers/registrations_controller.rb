class RegistrationsController < Devise::RegistrationsController
  include Emailable

  def create
    super {
      if @user.persisted?
        email_parameters = {
          to: @user.email,
          to_name: @user.first_name,
          subject: 'Thanks for joining Therapia!'
        }

        substitutions = {
          '-firstName-' => 'Cool',
          '-lastName-' => 'Beans'
        }

        template_id = 'c8ac2b43-365c-400e-9009-607700fb1f90'
        send_email(email_parameters, substitutions, template_id)
      end
    }
  end
end

