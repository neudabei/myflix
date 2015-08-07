require 'spec_helper'

describe Video do

  it {should belong_to(:category)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  it {should have_many(:reviews).order("created_at DESC")}

  describe "search_by_title" do

    it "returns an empty array if there is no match" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("hello")).to eq([])
    end

    it "returns and array of one video for an exact match" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!")
      expect(Video.search_by_title("Futurama")).to eq([futurama])
    end

    it "returns and array of one video for a partial match" do 
      futurama = Video.create(title: "Futurama", description: "Space Travel!")
      expect(Video.search_by_title("urama")).to eq([futurama])
    end

    it "returns an array of all matches ordered by created_at" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!", created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("Futu")).to eq([back_to_future, futurama])
    end

    it "returns an empty array for a search with an empty string" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("")).to eq([])
    end

  end
  
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
