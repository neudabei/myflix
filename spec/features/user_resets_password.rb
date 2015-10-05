require 'spec_helper'

feature "User resets password" do
  # Create temporary user
  background do
    User.create(email: "john@domain.com", password: "password123", full_name: "john doe")
  end

  scenario "user sucessfully resets the password" do # Just test the happy path since all other possibilites are tested on controller level
    go_to_signin_page_and_click_forgot_password_link
    enter_email_address
    open_email_and_click_reset_password_link
    enter_new_password
    sign_in_with_new_password
  end
end

private

def go_to_signin_page_and_click_forgot_password_link
  visit login_path
  click_link "Forgot password?"
end

def enter_email_address
  fill_in "email", with: "john@domain.com"
  click_button "Send Email"
end

def open_email_and_click_reset_password_link
  open_email "john@domain.com"
  current_email.click_link 'Reset my password'
end

def enter_new_password
  fill_in "password", with: "new_password"
  click_button "Reset Password"
  page.should have_content "Your password has been changed. Please sign in."
end

def sign_in_with_new_password
  fill_in "email", with: "john@domain.com"
  fill_in "password", with: "new_password"
  click_button "Sign in"
  page.should have_content "Welcome, you've logged in."
end