require 'spec_helper'

describe Friendship do

  before do
    @user1 = FactoryGirl.create(:user, username: "user1")
    @user2 = FactoryGirl.create(:user, username: "user2")
    @user3 = FactoryGirl.create(:user, username: "user3")
    Friendship.create(user_id: 1, friend_id: 2)
    Friendship.create(user_id: 1, friend_id: 3)
    Friendship.create(user_id: 2, friend_id: 3)
  end

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:friend_id) }
  it { should belong_to(:user) }
  it { should belong_to(:friend) }

  it "assigns many friends to a user" do 
    expect(@user1.friends.count).to eq(2)
  end

  it "assigns reverse friends to a user" do
    expect(@user2.inverse_friends.count).to eq(1)
  end

  it "total friends counts friends and friendships" do
    expect(@user2.total_friends.count).to eq(2)
  end


end
