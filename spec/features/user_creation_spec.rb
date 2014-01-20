require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe "User Signup" do
  before do
    page.visit root_path 
  end

  xit "sees dashboard after login" do
    click_on("Login with MapMyFitness")
    expect(page).to have_content "Aggregate Stats 14 Days"
  end

  # it "clicks the login button" do
  #   page.visit root_path 
  #   click_link "Login with Facebook"
  #   expect(current_path).to eq("http://www.facebook.com")
  # end

end

