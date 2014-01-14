class Friendship < ActiveRecord::Base
  attr_accessor :friend_name
  belongs_to :user 
  belongs_to :friend, :class_name => "User"

  validates :user_id, presence: true
  validates :friend_id, presence: true

  def self.cancel_between(user1, user2)
    friendships = where(:user_id => user1.id, :friend_id => user2.id) +
                  where(:user_id => user2.id, :friend_id => user1.id)
    friendships.each{ |f| f.update_attributes(:status => "rejected") }
    friendships.any?
  end

  def self.approve(id)
    Friendship.find(id).approve
  end

  def approve
    update_attributes(:status => "approved")
  end

  def self.remove(id)
    Friendship.find(id).remove
  end

  def remove
    update_attributes(:status => "rejected")
  end




end
