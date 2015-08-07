require 'spec_helper'

describe Category do 
  it {should have_many(:videos)}
  it {should validate_presence_of(:name)}

  describe "#recent_videos" do # #sign when we test instance methods

    it "returns the videos in the reverse chronical order by created_at" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "Space Travel", category: comedies, created_at: 1.day.ago)
      southpark = Video.create(title: "Southpark", description: "Crazy kids", category: comedies)
      expect(comedies.recent_videos).to eq([southpark, futurama])
    end

    it "returns all the videos if there are less than 6 videos" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "Space Travel", category: comedies, created_at: 1.day.ago)
      southpark = Video.create(title: "Southpark", description: "Crazy kids", category: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if there are more than 6 videos" do
      comedies = Category.create(name: "comedies")
      7.times { Video.create(title: "foo", description: "bar", category: comedies) }
      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      comedies = Category.create(name: "comedies")
      6.times { Video.create(title: "foo", description: "bar", category: comedies)}
      tonights_show = Video.create(title: "Tonights show", description: "talk show", category: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(tonights_show)
    end

    it "returns an empty array if the category does not have any videos" do
      comedies = Category.create(name: "comedies")
      expect(comedies.recent_videos).to eq([])
    end

  end
  
  # it "saves itself" do
  #   category = Category.new(name: "scifi")
  #   category.save
  #   expect(Category.first).to eq(category)
  #   expect(Category.first.name).to eq("scifi")
  # end

  # it "has many videos" do
  #   comedies = Category.create(name: "comedies")
  #   south_park = Video.create(title: "South Park", description: "funny video!", category: comedies)
  #   futurama = Video.create(title: "Futurama", description: "also quite funny", category: comedies)
  
  #   expect(comedies.videos).to eq([futurama, south_park])

  # end

end