require 'spec_helper'

describe Friendship do

  before do
    @user1 = FactoryGirl.create(:user, username: "user1")
    @user2 = FactoryGirl.create(:user, username: "user2")
    @user3 = FactoryGirl.create(:user, username: "user3")
    @user4 = FactoryGirl.create(:user, username: "user4")
    Friendship.create(user_id: 1, friend_id: 2, status: "approved")
    Friendship.create(user_id: 1, friend_id: 3, status: "approved")
    Friendship.create(user_id: 2, friend_id: 3, status: "approved")
  end

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:friend_id) }
  it { should validate_presence_of(:status) }
  it { should belong_to(:user) }
  it { should belong_to(:friend) }

  it "assigns many friends to a user" do 
    expect(@user1.friends.count).to eq(2)
  end

  it "assigns inverse friends to a user" do
    expect(@user2.inverse_friends.count).to eq(1)
  end

  it "can remove a friend" do
    expect(@user1.total_approved_friends.count).to eq(2)
    friendship = Friendship.find_by(user_id: @user1.id, friend_id: @user2.id)
    expect(Friendship.count).to eq(3)
    friendship.remove
    expect(Friendship.count).to eq(2)
    expect(@user1.total_approved_friends.count).to eq(1)
  end

  it "can approve a friend" do 
    expect(@user1.total_approved_friends.count).to eq(2)
    friendship = Friendship.create(user_id: @user4.id, friend_id: @user1.id, status: "pending")
    friendship.approve
    expect(@user1.total_approved_friends.count).to eq(3)
  end

  it "can reject a friend" do 
    expect(@user1.total_pending_friends.count).to eq(0)
    friendship = Friendship.create(user_id: @user4.id, friend_id: @user1.id, status: "pending")
    expect(@user1.total_pending_friends.count).to eq(1)
    expect(Friendship.count).to eq(4)
    friendship.reject
    expect(Friendship.count).to eq(3)
    expect(@user1.total_pending_friends.count).to eq(0)
  end

  context "changing friendship status" do
    it "does not create a new friendship id when one already exists" do
      expect(Friendship.last.id).to eq(3)
      friendship = Friendship.find_by(user_id: @user1.id, friend_id: @user2.id)
      friendship.approve
      expect(Friendship.last.id).to eq(3)
    end
  end
end
