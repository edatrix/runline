class User < ActiveRecord::Base
  validates :username, :presence => true
  validates :email, :presence => true

  def self.find_or_create_by_auth(auth)
    find_or_create_by_provider_and_uid(auth["provider"], 
                                       auth["uid"],
                                       username: auth["info"]["first_name"],
                                       email: auth["info"]["email"],
                                       token: auth["credentials"]["token"],
                                       secret: auth["credentials"]["secret"]
                                       )
  end

end
