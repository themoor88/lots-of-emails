module Emailable
  extend ActiveSupport::Concern

  def send_email(email_info)
    # Initiating the SendGrid API
    client = SendGrid::Client.new(api_user: ENV['MAILER_USERNAME'], api_key: ENV['MAILER_PASSWORD'])

    # Using the SMTP API header to pass client information
    header = Smtpapi::Header.new

    # Specifying the template
    header.add_filter('templates', 'template_id', email_info[:template_id])

    # Adding substitution tags for the template
    email_info[:substitutions].each {|sub| header.add_substitution(sub[0], [sub[1]])}

    # Parameters required for the API to work properly
    required_parameters = {
      text: ' ',
      html: ' ',
      from: 'wjkagzi@gmail.com',
      from_name: 'Wajid',
      smtpapi: header
    }

    # Adding the required parameters to the original parameters
    email_info[:email_parameters].merge!(required_parameters)

    # Initiating the message and sending the it along the API
    message = SendGrid::Mail.new(email_info[:email_parameters])
    client.send(message)
  end

  def send_confirmation_email(resource)
    email_info = {
      email_parameters: {
        to: resource.email,
        to_name: resource.first_name,
        subject: 'Thanks for joining Therapia!'
      },

      substitutions: {
        '-firstName-': resource.first_name,
        '-lastName-': resource.last_name
      },

      template_id: 'c8ac2b43-365c-400e-9009-607700fb1f90'
    }

    send_email(email_info)
  end
end