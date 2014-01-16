require 'spec_helper'

describe Run do
  before do
    @user1 = FactoryGirl.create(:user)
  end

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:distance) }
  it { should validate_presence_of(:run_time) }
  it { should validate_presence_of(:workout_datetime) }
  it { should belong_to(:user) }
  it { should validate_uniqueness_of(:workout_datetime) }

  it "should be created with valid attributes" do 
    FactoryGirl.create(:run).should be_valid
  end

  it "should be valid without a name" do 
    run = FactoryGirl.create(:run)
    run.update(name: nil)
    expect(run).to be_valid
  end

  it "converts the distance of a run into miles" do
    run = FactoryGirl.create(:run)
    expect(run.miles).to eq(3.11)
    run2 = FactoryGirl.create(:second_run)
    expect(run2.miles).to eq(6.21)
  end

  it "converts the run time to hours, minutes and seconds" do 
    run = FactoryGirl.create(:run)
    expect(run.time_in_minutes).to eq("15:40")
    run2 = FactoryGirl.create(:second_run, :run_time => 5200)
    expect(run2.time_in_minutes).to eq("1:24:23")
  end

  it "calculates the mile pace for a run in minutes and seconds" do 
    run = FactoryGirl.create(:run)
    run2 = FactoryGirl.create(:second_run)
    expect(run.mile_pace_in_minutes).to eq("5:02")
    expect(run2.mile_pace_in_minutes).to eq("5:22")
  end

  xit "finds the longest run from a user's runs" do
    run1 = Run.create(user_id: 1, distance: 1609.34, run_time: 43, workout_datetime: "Monday")
    run2 = Run.create(user_id: 1, distance: 1123.34, run_time: 12, workout_datetime: "Monday")
    run3 = Run.create(user_id: 1, distance: 160.34, run_time: 62, workout_datetime: "Monday")


    expect(Run.longest_run_for(@user1.id)).to eq(run1)
  end

  xit "finds the total mileage run for the last 14 days" do
  end
end
