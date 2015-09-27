# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :port           => 587,
  :address        => "smtp.mailgun.org",
  :domain         => 'lots-of-emails.herokuapp.com',
  :user_name      => ENV['MAILGUN_USERNAME'],
  :password       => ENV['MAILGUN_PASSWORD'],
  :authentication => :plain,
}