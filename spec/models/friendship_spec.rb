require 'spec_helper'

describe Friendship do
  it "must have a user associated with it" do
    user = FactoryGirl.create(:user)
    friendship = FactoryGirl.create(:friendship)
    friendship.update(:user_id => nil)
    expect(friendship).not_to be_valid
  end

  it "must have a friend associated with it" do
    user = FactoryGirl.create(:user)
    friendship = FactoryGirl.create(:friendship)
    friendship.update(:friend_id => nil)
    expect(friendship).not_to be_valid
  end

  xit "has a friend that is also a user" do 
    expect(friend.class).to eq(User)
  end
end
