class Friendship < ActiveRecord::Base
  attr_accessor :friend_name
  belongs_to :user 
  belongs_to :friend, :class_name => "User"

  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates :status, presence: true

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
