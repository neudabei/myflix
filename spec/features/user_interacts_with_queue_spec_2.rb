require 'spec_helper'

feature "add videos to queue" do
  background do
    User.create(email: "john@domain.com", password: "password123", full_name: "john doe")
    tv_show = Fabricate(:category)
    @peaky_blinders = Fabricate(:video, title: "Peaky Blinders", category: tv_show)
    @video1 = Video.create(title: "Peaky Blinders", description: "A Mafia story in the 1920s in England", large_cover_url: "peaky_blinders.jpg", small_cover_url: "peaky_blinders_small.jpg", category: tv_show)
    video2 = Video.create(title: "The Americans", description: "Spy story in America, in the 1980s", large_cover_url: "americans.jpg", small_cover_url: "americans_small.jpg", category_id: 1)
    video3 = Video.create(title: "House of Cards", description: "Netflix show about a corrupt politician.", large_cover_url: "house_of_cards.jpg", small_cover_url: "house_of_cards_small.jpg", category_id: 1)
    video4 = Video.create(title: "Daredevil", description: "Marvel and Netflix show about a blind superhero.", large_cover_url: "daredevil.jpg", small_cover_url: "daredevil_small.jpg", category_id: 1)
  end

  scenario "login" do
    visit login_path
    fill_in "email", with: "john@domain.com"
    fill_in "password", with: "password123"
    click_button "Sign in"
    page.should have_content "Welcome, you've logged in."
    click_link("#{@video1.id}")
    click_link("#{@video1.title}")
  end

  scenario "click on video" do
    # binding.pry
    # click_link('1')
  end

  scenario "add video to my queue" do
  end
end

# testing queue feature

# login
# go to video
# press my queue button
# to to my queue page
# if video is there follow the link of the video and make sure you go to the video show page + ensure it is the correct video (check video title)
# + my queue button should not be visible anymore on video page, because video is already on my queue
# then go to the homepage and add more videos (click on vide and on show page multiple times)
# then go to my queue and reorder the videos and click update instance queue and verify they come back correctly