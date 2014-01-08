require 'spec_helper'

describe User do

  it "should require a username" do
    User.new(:username => nil).should_not be_valid
  end

  it "should require an email" do
    User.new(:username => "Bob", :email => "").should_not be_valid
  end

  it "can have many runs" do 
    user = User.create(:username => "Valid Username", :email => "valid@email.com")
    run = Run.create(:user_id => user.id)
    run2 = Run.create(:user_id => user.id)
    expect(user.runs.size).to eq 2
  end

end
