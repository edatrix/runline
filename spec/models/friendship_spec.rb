require 'spec_helper'

describe Friendship do
  it "must have a user associated with it" do
    user = FactoryGirl.create(:user)
    friendship = FactoryGirl.create(:friendship)
    friendship.update(:user_id => nil)
    expect(friendship).not_to be_valid
  end
end
