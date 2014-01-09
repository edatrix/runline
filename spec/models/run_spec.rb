require 'spec_helper'

describe Run do

  it "should be created with valid attributes" do 
    FactoryGirl.create(:run).should be_valid
  end

  it "validates that a run must belong to a user" do 
    run = FactoryGirl.create(:run)
    run.update(user_id: nil)
    expect(run).not_to be_valid
  end

  it "should validate that a run has a distance" do 
    run = FactoryGirl.create(:run)
    run.update(distance: nil)
    expect(run).not_to be_valid
  end

  it "should validate that a run has a run time" do 
    run = FactoryGirl.create(:run)
    run.update(run_time: nil)
    expect(run).not_to be_valid
  end

  it "should validate that a run occurred on a certain datetime" do 
    run = FactoryGirl.create(:run)
    run.update(workout_datetime: nil)
    expect(run).not_to be_valid
  end

  it "should be valid without a name" do 
    run = FactoryGirl.create(:run)
    run.update(name: nil)
    expect(run).to be_valid
  end
end
