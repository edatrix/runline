require 'spec_helper'

describe User do

  it "should require a username" do 
    user = FactoryGirl.create(:user)
    user.should be_valid
  end

  it "should require a unique username" do
    user = FactoryGirl.create(:user)
    user.should be_valid
    FactoryGirl.build(:user).should_not be_valid
  end

  it "should require an email" do
    user = FactoryGirl.create(:user)
    user.update(:email => "").should be_false
  end

  it "can have many runs" do 
    user = FactoryGirl.create(:user)
    run = FactoryGirl.create(:run, user_id: user.id)
    second_run = FactoryGirl.create(:second_run, user_id: user.id)
    expect(user.runs.size).to eq 2
  end

end
