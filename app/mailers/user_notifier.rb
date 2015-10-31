class UserNotifier < ApplicationMailer
  def welcome_email(user)
    @user = user
    client = SendGrid::Client.new(api_user: ENV['MAILER_USERNAME'], api_key: ENV['MAILER_PASSWORD'])
    template = SendGrid::Template.new('c8ac2b43-365c-400e-9009-607700fb1f90')
    recipients = [SendGrid::Recipient.new(@user.email)]
    mailer_defaults = {
      from: 'wjkagzi@gmail.com',
      subject: ' ',
      html: '<div></div>'
    }
    mailer = SendGrid::TemplateMailer.new(client, template, recipients)
    mailer.mail(mailer_defaults)
  end
end
