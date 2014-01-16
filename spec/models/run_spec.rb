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
  xit { should validate_uniqueness_of(:workout_datetime) }

  it "should be created with valid attributes" do 
    FactoryGirl.create(:run).should be_valid
  end

  xit "validates that a run is unique (does not occur at the same time as another run)" do
    run = FactoryGirl.create(:run)
    #run2 = FactoryGirl.build(:third_run)
    puts run.workout_datetime
    expect(run).not_to be_valid
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

  it "converts the run time to minutes and seconds" do 
    run = FactoryGirl.create(:run)
    expect(run.time_in_minutes).to eq("15:40")
  end

  xit "calculates the mile pace for a run in minutes and seconds" do 
    run = FactoryGirl.create(:run)
    expect(run.pace).to eq("5:03")
  end

  it "finds the longest run from a user's runs" do
    run1 = Run.create(user_id: 1, distance: 1609.34, run_time: 43, workout_datetime: "Monday")
    run2 = Run.create(user_id: 1, distance: 1123.34, run_time: 12, workout_datetime: "Monday")
    run3 = Run.create(user_id: 1, distance: 160.34, run_time: 62, workout_datetime: "Monday")


    expect(Run.longest_run_for(@user1.id)).to eq(run1)
  end

  xit "converts run_time from seconds to hours" do
    run1 = Run.create(user_id: 1, distance: 1609.34, run_time: 1800, workout_datetime: "Monday")

    expect(run1.time_in_hours).to eq(0.5)
  end

  xit "finds a users average pace in miles per hour" do
    run1 = Run.create(user_id: 1, distance: 1609.34, run_time: 20, workout_datetime: "Monday")

    expect(Run.average_pace_in_mph_for(@user1.id)).to eq(3.00)
  end

  xit "finds the total mileage run for the last 14 days" do
  end
end
