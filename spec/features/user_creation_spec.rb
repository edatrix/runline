require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe "User Signup" do
  it "can see login button" do
    page.visit root_path 
    expect(page).to have_content "Login with Facebook"
  end

  # it "clicks the login button" do
  #   page.visit root_path 
  #   click_link "Login with Facebook"
  #   expect(current_path).to eq("http://www.facebook.com")
  # end

end
