require 'spec_helper'

describe Video do

  it {should belong_to(:category)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  
  # it "saves itself" do
  #   video = Video.new(title: "awesome movie", description: "this movie is awesome and worth watching.", small_cover_url: "awesome_poster_small.jpg", large_cover_url: "awesome_poster_large.jpg")
  #   video.save
  #   Video.first.title.should == "awesome movie"
  #   expect(Video.first.description).to eq("this movie is awesome and worth watching.")
  #   expect(Video.first).to eq(video)
  # end

  # it "belongs to category" do
  #   dramas = Category.create(name: "dramas")
  #   monk = Video.create(title: "Monk", description: "Neurotic detective.", category: dramas)
  #   expect(monk.category).to eq(dramas)
  # end

  # it "does not save a video without a title" do
  #   video = Video.create(description: "video is about this and that")
  #   expect(Video.count).to eq(0)
  # end

  # it "does not save a video without a description" do
  #   video = Video.create(title: "newvideo")
  #   expect(Video.count).to eq(0)
  # end

end
