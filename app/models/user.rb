class User < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true

  has_many :runs
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user 

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
