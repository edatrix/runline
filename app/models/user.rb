require 'faraday'

class User < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true

  has_many :runs
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  def self.find_or_create_by_auth(user_data)
    find_or_create_by_provider_and_uid(user_data.provider, 
                                       user_data.uid,
                                       username: user_data.username,
                                       email: user_data.email,
                                       token: user_data.token)
  end

  def add_friend(friend)
    unless total_approved_friends.include?(friend)
      create_or_update_friendship(friend)
    end
  end

  def approve_friend(friend)
    friendship = Friendship.find_by(user_id: friend.id, friend_id: id) ||
                 Friendship.find_by(user_id: id, friend_id: friend.id)
    friendship.update(status: "approved")
  end

  # def reject_friend(friend)
  #   friendship = Friendship.find_by(user_id: friend.id, friend_id: id)
  #   friendship.update(status: "rejected")
  # end

  def create_or_update_friendship(friend)
    if Friendship.find_by(user_id: friend.id, friend_id: id) ||
       Friendship.find_by(user_id: id, friend_id: friend.id)
      friendship = Friendship.find_by(user_id: friend.id, friend_id: id) ||
                  Friendship.find_by(user_id: id, friend_id: friend.id)
      friendship.update(status: "pending")
    else
      Friendship.create(user_id: id, friend_id: friend.id, status: "pending")
      send_friend_request_email(friend.email, self.username)
    end
  end

  def send_friend_request_email(email, username)
    FriendRequestNotifier.email_friend(email, username).deliver
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

  def total_approved_friendships
    total = approved_friendships << approved_inverse_friendships
    total.flatten
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

  def total_pending_friendships
    total = pending_friendships << pending_inverse_friendships
    total.flatten
  end

  def pending_friendships
    friendships.where(status: "pending")
  end

  def pending_inverse_friendships
    inverse_friendships.where(status: "pending")
  end

end
