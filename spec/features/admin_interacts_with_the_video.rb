require "spec_helper"

feature "Admin interacts with the video" do
  scenario "admin adds a video" do
    category = Fabricate(:category)
    admin = Fabricate(:admin)

    admin_logs_in(admin)
    add_video(category)

    sign_out
    sign_in # as normal user

    video_should_have_been_added
  end

  def admin_logs_in(admin)
    visit login_path
    fill_in "Email Address", with: admin.email
    fill_in "Password", with: admin.password
    click_button "Sign in" 
  end

  def add_video(category)
    visit new_admin_video_path
    fill_in "video_title", with: "Monk"
    select "#{category.name}", :from => "video_category_id"
    fill_in "video_description", with: "A TV show about a neurotic detective"
    attach_file("Large cover", "spec/support/uploads/monk_large.jpg")
    attach_file("Small cover", "spec/support/uploads/monk_small.jpg")
    fill_in "Video url", with: "https://s3-eu-west-1.amazonaws.com/myflix112015/video.mp4"
    click_button "Add video"
  end

  def video_should_have_been_added
    visit videos_path
    find(:xpath, "//html/body/section/article/div[1]/div[1]/a").click
    expect(page).to have_selector("img[src='/uploads/monk_large.jpg']")
    expect(page).to have_selector("a[href='https://s3-eu-west-1.amazonaws.com/myflix112015/video.mp4']")
  end
end