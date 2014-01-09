require 'spec_helper'

describe User do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should have_many(:friendships) }
  it { should have_many(:friends) }
  it { should have_many(:inverse_friendships) }
  it { should have_many(:inverse_friends) }

  it "should be created with valid attributes" do 
    user = FactoryGirl.create(:user)
    user.should be_valid
  end

  it "can have many runs" do 
    user = FactoryGirl.create(:user)
    run = FactoryGirl.create(:run, user_id: user.id)
    second_run = FactoryGirl.create(:second_run, user_id: user.id)
    expect(user.runs.size).to eq 2
  end

end
