# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Runline::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'runline.tk:3000',
  :enable_starttls_auto => true
}
