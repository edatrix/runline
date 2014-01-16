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

  def data_connection
    Faraday.new(:url => "https://oauth2-api.mapmyapi.com/v7.0/") do |connection|
      connection.headers["Api-Key"] = ENV['MMF_API_KEY']
      connection.headers["Authorization"] = "Bearer #{token}"
    end
  end

  def photo
    data_connection.get("user_profile_photo/#{uid}").body
  end

  def workouts
    data_connection.get("workout/").body
  end

end
