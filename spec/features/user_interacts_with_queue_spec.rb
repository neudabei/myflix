require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do

    tv_show = Fabricate(:category)
    peaky_blinders = Fabricate(:video, title: "Peaky Blinders", category: tv_show)
    daredevil = Fabricate(:video, title: "Daredevil", category: tv_show)
    americans = Fabricate(:video, title: "The Americans", category: tv_show)

    sign_in
    find("a[href='/videos/#{peaky_blinders.id}']").click
    page.should have_content(peaky_blinders.title)

    click_link("+ My Queue")
    page.should have_content(peaky_blinders.title)

    visit video_path(peaky_blinders)
    page.should_not_have_content("+ My Queue")

  end
end
