require 'spec_helper'

feature "User signs in" do
  scenario "with existing username" do
    alice = Fabricate(:user)
    sign_in(alice)
    page.should have_content "Welcome, you've logged in."
  end

  scenario "with deactivated user" do
    alice = Fabricate(:user, active: false)
    sign_in(alice)
    expect(page).not_to have_content(alice.full_name)
    expect(page).to have_content("Your account has been suspended. Please contact the customer service.")
  end
end


