# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "The Wire", description: "One of the best TV shows ever made.", large_cover_url: "wire.jpg")
Video.create(title: "Sopranos", description: "A very entertaining and well made TV show.", large_cover_url: "sopranos.jpg")
Video.create(title: "The Simpsons", description: "A classic that needs no description.", large_cover_url: "simpsons")