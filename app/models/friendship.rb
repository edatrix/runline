class Friendship < ActiveRecord::Base
  attr_accessor :friend_name
  belongs_to :user 
  belongs_to :friend, :class_name => "User"

  validates :user_id, presence: true
  validates :friend_id, presence: true

   def add_friend
    user_id = current_user.id
    friend = User.find_by(username: params[:username])
    Friendship.create(user_id: user_id, friend_id: friend.id)
  end


end
