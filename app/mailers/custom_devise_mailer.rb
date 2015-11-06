class CustomDeviseMailer < Devise::Mailer
  include Emailable
  include Devise::Controllers::UrlHelpers

  def confirmation_instructions(record, token, opts={})
    if record.actable_type == 'Patient'
      options = {
        template_id: ENV['PATIENT_CONFIRMATION_EMAIL_ID'],
        url: confirmation_url(record, confirmation_token: token)
      }
      send_email_to_patient(record, options)
    elsif record.actable_type == 'Professional'
      options = {
        template_id: ENV['PROFESSIONAL_CONFIRMATION_EMAIL_ID'],
        url: confirmation_url(record, confirmation_token: token),
        admin_template_id: ENV['VERIFY_PROFESSIONAL_EMAIL_ID']
      }
      send_email_to_professional(record, options)
      send_email_to_admin(record, options)
    end
  end

  def reset_password_instructions(record, token, opts={})
    if record.actable_type == 'Patient'
      options = {
        template_id: ENV['PATIENT_RESET_PASSWORD_EMAIL_ID'],
        url: edit_patient_password_url(record, reset_password_token: token)
      }
      send_email_to_patient(record, options)
    elsif record.actable_type == 'Professional'
      options = {
        template_id: ENV['PROFESSIONAL_RESET_PASSWORD_EMAIL_ID'],
        url: edit_professional_password_url(record, reset_password_token: token)
      }
      send_email_to_professional(record, options)
    end
  end

  def unlock_instructions(record, token, opts={})
    if record.actable_type == 'Patient'
      options = {
        template_id: ENV['PATIENT_UNLOCK_EMAIL_ID'],
        url: unlock_url(record, unlock_token: token)
      }
      send_email_to_patient(record, options)
    elsif record.actable_type == 'Professional'
      options = {
        template_id: ENV['PROFESSIONAL_UNLOCK_EMAIL_ID'],
        url: unlock_url(record, unlock_token: token)
      }
      send_email_to_professional(record, options)
    end
  end
end