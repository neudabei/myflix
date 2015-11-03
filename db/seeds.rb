# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

drama = Category.create!(name: "Drama")
cartoon = Category.create!(name: "Cartoon")
detective = Category.create!(name: "Detective")

Video.create!(title: "The Wire", description: "One of the best TV shows ever made.", large_cover: "/seed/wire.jpg", small_cover: "/seed/wire_small.jpg", category: detective ) # changed from category_id: 3
Video.create!(title: "Sopranos", description: "A very entertaining and well made TV show.", large_cover: "/seed/sopranos.jpg", small_cover: "/seed/sopranos_small.jpg", category: drama)
Video.create!(title: "The Simpsons", description: "A classic that needs no description.", large_cover: "/seed/simpsons.jpg", small_cover: "/seed/simpsons_small.jpg", category: cartoon)

monk = Video.create!(title: "Monk", description: "A neurotic detective.", large_cover: "/seed/monk.jpg", small_cover: "/seed/monk_small.jpg", category_id: 3)
Video.create!(title: "Futurama", description: "Another show from the creators of The Simpsons.", large_cover: "/seed/futurama.jpg", small_cover: "/seed/futurama_small.jpg", category_id: 2)
Video.create!(title: "Family Guy", description: "Like Simpsons, but even crazier and faster.", large_cover: "/seed/family_guy.jpg", small_cover: "/seed/family_guy_small.jpg", category_id: 2)
Video.create!(title: "Peaky Blinders", description: "A Mafia story in the 1920s in England", large_cover: "/seed/peaky_blinders.jpg", small_cover: "/seed/peaky_blinders_small.jpg", category_id: 1)
Video.create!(title: "The Americans", description: "Spy story in America, in the 1980s", large_cover: "/seed/americans.jpg", small_cover: "/seed/americans_small.jpg", category_id: 1)
Video.create!(title: "House of Cards", description: "Netflix show about a corrupt politician.", large_cover: "/seed/house_of_cards.jpg", small_cover: "/seed/house_of_cards_small.jpg", category_id: 1)
Video.create!(title: "Daredevil", description: "Marvel and Netflix show about a blind superhero.", large_cover: "/seed/daredevil.jpg", small_cover: "/seed/daredevil_small.jpg", category_id: 1)
Video.create!(title: "Breaking Bad", description: "Chemistry teacher changes his life by going into the drug business.", large_cover: "/seed/breaking_bad.jpg", small_cover: "/seed/breaking_bad_small.jpg", category_id: 1)

Video.create!(title: "Southpark", description: "Cartman and friends.", large_cover: "/seed/south_park.jpg", small_cover: "/seed/south_park_small.jpg", category_id: 2)
Video.create!(title: "Ray Donovan", description: "fixes problems of the rich and famous in Hollywood", small_cover: "/seed/ray_donovan_small.jpg", large_cover: "/seed/ray_donovan.jpg", category_id: 1)
Video.create!(title: "Better Call Saul", description: "The life of the lawyer from Breaking Bad, before meeting Walter White", small_cover: "/seed/better_call_saul_small.jpg", large_cover: "/seed/better_call_saul.jpg", category_id: 1)

admin = User.create(full_name: "Admin Dude", password: "hello", email: "admin@domain.com", admin: true)
bob = User.create(full_name: "Bob Meister", password: "hello", email: "email@domain.com")
john = User.create(full_name: "John Doe", password: "hello", email: "john@domain.com")

Review.create(user: bob, video: monk, rating: 5, content: "This is a good show.")
Review.create(user: bob, video: monk, rating: 2, content: "This show is not so good.")