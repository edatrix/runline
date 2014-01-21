class FriendRequestNotifier < ActionMailer::Base
  include Resque::Mailer
  default from: "navyosu@gmail.com"

  def email_friend(email, requestor_name)
    @requestor = requestor_name
    mail(to: email,
      subject: "#{@requestor} would like to run with you on Runline!")
  end

end
