require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do

    tv_show = Fabricate(:category)
    peaky_blinders = Fabricate(:video, title: "Peaky Blinders", category: tv_show)
    daredevil = Fabricate(:video, title: "Daredevil", category: tv_show)
    americans = Fabricate(:video, title: "The Americans", category: tv_show)

    sign_in

    add_video_to_queue(peaky_blinders)
    expect_video_to_be_in_queue(peaky_blinders)

    visit video_path(peaky_blinders)
    expect_link_not_to_be_seen("+ My Queue")

    add_video_to_queue(daredevil)
    add_video_to_queue(americans)

    set_video_position(peaky_blinders, 3)
    set_video_position(daredevil, 1)
    set_video_position(americans, 2) 

    update_queue

    expect_video_position(daredevil, 1)
    expect_video_position(peaky_blinders, 3)
    expect_video_position(americans, 2)

  end


  def expect_video_to_be_in_queue(video)
    expect(page).to have_content(video.title)
  end

  def expect_link_not_to_be_seen(link_text)
    expect(page).not_to have_content(link_text)
  end

  def update_queue
    click_button "Update Instant Queue"
  end

  def add_video_to_queue(video)
    visit home_path
    click_on_video_on_home_page(video)
    click_link "+ My Queue"
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end
    
end
