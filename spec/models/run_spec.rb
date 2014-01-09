require 'spec_helper'

describe Run do

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
    run2 = FactoryGirl.build(:third_run)
    puts run.workout_datetime
    expect(run).not_to be_valid
  end

  it "should be valid without a name" do 
    run = FactoryGirl.create(:run)
    run.update(name: nil)
    expect(run).to be_valid
  end

  xit "converts the distance of a run into miles" do
    run = FactoryGirl.create(:run)
    expect(run.mileage).to eq(3.1)
  end

  xit "converts the run time to minutes and seconds" do 
    run = FactoryGirl.create(:run)
    expect(run.run_time).to eq("7:10")
  end
end
