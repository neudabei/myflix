require 'spec_helper'

feature "User signs in" do
  background do
    User.create(email: "john@domain.com", password: "password123", full_name: "john doe")
  end

  scenario "with existing username" do
    visit login_path
    fill_in "email", with: "john@domain.com" # signing in with john requires him to be in the database, that's why we need the background before
    fill_in "password", with: "password123"
    click_button "Sign in"
    page.should have_content "Welcome, you've logged in."
  end
end


