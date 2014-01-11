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

  def total_friends
    friends << inverse_friends
  end

  def add_friend(friend)
    unless current_friends.include?(friend)
      friend = User.find_by(username: friend)
      Friendship.create(user_id: id, friend_id: friend.id)
    end
  end

  def unfriend(friend)
    if current_friends.include?(friend)
     friend = User.find_by(username: friend)
     friendship = Friendship.find_by(user_id: id, friend_id: friend.id)
     friendship.delete
    end
  end

  def current_friends
    friends.collect do |friend|
      friend.username
    end
  end

end
