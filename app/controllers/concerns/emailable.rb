module Emailable
  extend ActiveSupport::Concern

  def send_email(email_parameters, substitutions, template_id)
    header = Smtpapi::Header.new
    client = SendGrid::Client.new(api_user: ENV['MAILER_USERNAME'], api_key: ENV['MAILER_PASSWORD'])

    header.add_filter('templates', 'template_id', template_id)

    substitutions.each do |sub|
      debugger
      header.add_substitution(sub[0], [sub[1]])
    end

    required_parameters = {
      text: ' ',
      html: ' ',
      from: 'wjkagzi@gmail.com',
      from_name: 'Wajid',
      smtpapi: header
    }

    email_parameters.merge!(required_parameters)
    message = SendGrid::Mail.new(email_parameters)
    client.send(message)
  end
end
