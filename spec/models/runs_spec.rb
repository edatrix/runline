require 'spec_helper'

describe Runs do

  it "validates that a run must belong to a user" do
    user = User.new(:user_id => nil) 
    expect(user).not_to be_valid
  end
end
