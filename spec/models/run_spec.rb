require 'spec_helper'

describe Run do

  it "validates that a run must belong to a user" do
    run = Run.new(:user_id => nil) 
    expect(run).not_to be_valid
  end

  it "validates that a run must belong to a user" do
    run = Run.new(:user_id => nil) 
    expect(run).not_to be_valid
  end

end
