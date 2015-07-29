require 'spec_helper'

describe Category do 

  it {should have_many(:videos)}
  
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