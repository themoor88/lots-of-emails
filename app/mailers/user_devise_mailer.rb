class UserDeviseMailer < ActionMailer::Base
  include Emailable
  include Devise::Controllers::UrlHelpers

  def confirmation_instructions(record, token, opts={})
    options = {
      to: record.email,
      to_name: record.first_name || '',
      template_id: Figaro.env.user_confirmation_email_id,
      substitutions: {
        '-firstName-': record.first_name || '',
        '-url-': confirmation_url(record, confirmation_token: token)
      }
    }
    setup_email_info_and_send_email(options)
  end

  def reset_password_instructions(record, token, opts={})
    options = {
      to: record.email,
      to_name: record.first_name || '',
      template_id: Figaro.env.patient_reset_password_email_id,
      substitutions: {
        '-firstName-': record.first_name || '',
        '-url-': edit_user_password_url(record, reset_password_token: token)
      }
    }
    setup_email_info_and_send_email(options)
  end

  def unlock_instructions(record, token, opts={})
    options = {
      to: record.email,
      to_name: record.first_name || '',
      template_id: Figaro.env.user_unlock_account_email_id,
      substitutions: {
        '-firstName-': record.first_name || '',
        '-url-': unlock_url(record, unlock_token: token)
      }
    }
    setup_email_info_and_send_email(options)
  end
end