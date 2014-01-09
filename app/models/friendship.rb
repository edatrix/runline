class Friendship < ActiveRecord::Base
  belongs_to :user 

  validates :user_id, presence: true
  validates :friend_id, presence: true
end
