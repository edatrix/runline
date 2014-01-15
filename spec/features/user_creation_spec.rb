require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe "User Signup" do
  before do
    page.visit root_path 
  end

  it "can see login button" do
    expect(page).to have_content "Login with MapMyFitness"
  end

  it "sees dashboard after login" do
    click_on("Login with MapMyFitness")
    expect(page).to have_content "RUN! RUN! RUN!"
  end

  # it "clicks the login button" do
  #   page.visit root_path 
  #   click_link "Login with Facebook"
  #   expect(current_path).to eq("http://www.facebook.com")
  # end

end
