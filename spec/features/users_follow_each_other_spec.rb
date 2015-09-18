require 'spec_helper'

feature "users follows other user" do
  scenario "user follows and unfollows someone" do
    
    bob = Fabricate(:user)
    alice = Fabricate(:user)

    tv_show = Fabricate(:category)
    video = Fabricate(:video, title: "Daredevil", category: tv_show)
    review = Fabricate(:review, user: alice, video: video)

    sign_in(bob)
    click_on_video_on_home_page(video)

    click_link alice.full_name
    click_link "Follow"

    expect(page).to have_content(alice.full_name)
 
    unfollow(alice)
    expect(page).not_to have_content(alice.full_name)
  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end