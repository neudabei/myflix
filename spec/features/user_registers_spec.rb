require 'spec_helper'

feature "User registers", {js: true, vcr: true} do
  background do
    visit register_path
  end

  scenario "with valid user info and valid card" do
    fill_in_valid_user_details
    fill_in_credit_card_details("4242424242424242")
    click_button "Sign Up"
    expect(page).to have_content("Thank you for registering with MyFlix. Please sign in now.")
  end

  scenario "with valid user info and invalid card" do
    fill_in_valid_user_details
    fill_in_credit_card_details("123")
    click_button "Sign Up"
    expect(page).to have_content("This card number looks invalid.")
  end

  scenario "with valid user info and declined card" do
    fill_in_valid_user_details
    fill_in_credit_card_details("4000000000000002")
    click_button "Sign Up"
    expect(page).to have_content("Your card was declined")
  end

  scenario "with invalid user info and valid card" do
    fill_in "Email Address", with: "john@example.com"
    fill_in_credit_card_details("4242424242424242")
    click_button "Sign Up"
    expect(page).to have_content("Invalid user information. Please check the errors below.")
  end

  scenario "with invalid user info and invalid card" do
    fill_in "Email Address", with: "john@example.com"
    fill_in_credit_card_details("123")
    click_button "Sign Up"
    expect(page).to have_content("This card number looks invalid.")
  end

  scenario "with invalid user info and declined card" do
    fill_in "Email Address", with: "john@example.com"
    fill_in_credit_card_details("4000000000000002")
    click_button "Sign Up"
    expect(page).to have_content("Invalid user information. Please check the errors below.")
  end

  def fill_in_valid_user_details
    fill_in "Email Address", with: "john@example.com"
    fill_in "Password", with: "123"
    fill_in "Full Name", with: "John Doe"
  end

  def fill_in_credit_card_details(credit_card_number)
    fill_in "Credit Card Number", with: credit_card_number
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
  end
end
