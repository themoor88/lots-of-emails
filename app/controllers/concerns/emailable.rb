module Emailable
  extend ActiveSupport::Concern

  def send_email(email_info)
    # Initiating the SendGrid API
    client = SendGrid::Client.new(api_key: Figaro.env.sendgrid_api_key)

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
      from: Figaro.env.sendgrid_from_email,
      from_name: Figaro.env.sendgrid_from_name,
      smtpapi: header
    }

    # Adding the required parameters to the original parameters
    email_info[:email_parameters].merge!(required_parameters)

    # Initiating the message and sending the it along the API
    message = SendGrid::Mail.new(email_info[:email_parameters])
    client.send(message)
  end

  # This method is very generic to acccept an options paramter.
  # The options should contain a template_id, substitutions and a recipient.
  def setup_email_info_and_send_email(options)
    email_info = {
      email_parameters: {
        to: (Rails.env.development? || Rails.env.test?) ? Figaro.env.dev_email_to : options[:to],
        to_name: options[:to_name] || '',
        subject: ' '
      },

      substitutions: options[:substitutions] || {},
      template_id: options[:template_id]
    }

    # only send email if the ENV says so (hacky because ENV can only store strings)
    send_email(email_info) if Figaro.env.send_email.downcase.eql?('true')
  end
end