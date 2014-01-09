require 'spec_helper'

describe Friendship do

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:friend_id) }
  it { should belong_to(:user) }

  xit "has a friend that is also a user" do 
    expect(friend.class).to eq(User)
  end
end
