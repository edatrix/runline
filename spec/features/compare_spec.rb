require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe "Compare Friend Stats" do
  before do
    visit root_path
    click_on("Login with MapMyFitness")
    @user = FactoryGirl.create(:user)
    Friendship.create(user_id: @user.id, friend_id: User.first.id, status: "approved")
  end

  it "allows a user to compare stats with a friend" do
    expect(User.first.username).to eq("Jane")
    visit friendships_path
    click_on("Compare")
    current_path.should eq(compare_path(@user.id))
    expect(page).to have_content("How do you stack up against #{@user.username}?")
  end

end
