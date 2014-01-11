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
    unless total_approved_friends.include?(friend)
      friend = User.find_by(username: friend)
      Friendship.create(user_id: id, friend_id: friend.id, status: "pending")
    end
  end

  def approve_friend(friend)
    friendship = Friendship.find_by(user_id: friend.id, friend_id: id)
    friendship.update(status: "approved")
  end

  def reject_friend(friend)
    friendship = Friendship.find_by(user_id: friend.id, friend_id: id)
    friendship.update(status: "rejected")
  end

  def unfriend(friend)
    if total_approved_friends.include?(friend)
      friendship = Friendship.find_by(user_id: id, friend_id: friend.id) ||
                   Friendship.find_by(user_id: friend.id, friend_id: id)
      friendship.update(status: "rejected")
    end
  end

  def total_pending_friends
    total = pending_friends << pending_inverse_friends
    total.flatten
  end

  def total_approved_friends
    total = approved_friends << approved_inverse_friends
    total.flatten
  end



  def approved_friends
    approved_friendships.where(user_id: id).collect do |friendship|
      friendship.friend
    end 
  end

  def approved_inverse_friends
    approved_inverse_friendships.where(friend_id: id).collect do |friendship|
      friendship.user
    end
  end

  def approved_friendships
    friendships.where(status: "approved")
  end

  def approved_inverse_friendships
    inverse_friendships.where(status: "approved")      
  end

  def pending_friends
    pending_friendships.where(user_id: id).collect do |friendship|
      friendship.friend
    end 
  end

  def pending_inverse_friends
    pending_inverse_friendships.where(friend_id: id).collect do |friendship|
      friendship.user
    end
  end

  def pending_friendships
    friendships.where(status: "pending")
  end

  def pending_inverse_friendships
    inverse_friendships.where(status: "pending")      
  end

end
