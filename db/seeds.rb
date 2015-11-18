
# Special syntax for seeding image uploads with Carrierwave

# (File.open(File.join(Rails.root, 'public/uploads/seed/wire.jpg')))
#  => Video.create(title: "/Bla/Blub6.png", description: "Testing slashes", :small_cover => (File.open(File.join(Rails.root, 'public/uploads/seed/wire.jpg'))))


drama = Category.create!(name: "Drama")
cartoon = Category.create!(name: "Cartoon")
detective = Category.create!(name: "Detective")

Video.create!(title: "The Wire", description: "One of the best TV shows ever made.", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/wire.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/wire_small.jpg", category: detective ) # changed from category_id: 3
Video.create!(title: "Sopranos", description: "A very entertaining and well made TV show.", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/sopranos.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/sopranos_small.jpg", category: drama)
Video.create!(title: "The Simpsons", description: "A classic that needs no description.", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/simpsons.png", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/simpsons_small.jpg", category: cartoon)

monk = Video.create!(title: "Monk", description: "A neurotic detective.", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/monk.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/monk_small.jpg", category_id: 3)
Video.create!(title: "Futurama", description: "Another show from the creators of The Simpsons.", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/futurama.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/futurama_small.jpg", category_id: 2)
Video.create!(title: "Family Guy", description: "Like Simpsons, but even crazier and faster.", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/family_guy.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/family_guy_small.jpg", category_id: 2)
Video.create!(title: "Peaky Blinders", description: "A Mafia story in the 1920s in England", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/peaky_blinders.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/peaky_blinders_small.jpg", category_id: 1)
Video.create!(title: "The Americans", description: "Spy story in America, in the 1980s", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/americans.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/americans_small.jpg", category_id: 1)
Video.create!(title: "House of Cards", description: "Netflix show about a corrupt politician.", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/house_of_cards.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/house_of_cards_small.jpg", category_id: 1)
Video.create!(title: "Daredevil", description: "Marvel and Netflix show about a blind superhero.", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/daredevil.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/daredevil_small.jpg", category_id: 1)
Video.create!(title: "Breaking Bad", description: "Chemistry teacher changes his life by going into the drug business.", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/breaking_bad.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/breaking_bad_small.jpg", category_id: 1)

Video.create!(title: "Southpark", description: "Cartman and friends.", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/south_park.jpg", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/south_park_small.jpg", category_id: 2)
Video.create!(title: "Ray Donovan", description: "fixes problems of the rich and famous in Hollywood", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/ray_donovan_small.jpg", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/ray_donovan.jpg", category_id: 1)
Video.create!(title: "Better Call Saul", description: "The life of the lawyer from Breaking Bad, before meeting Walter White", remote_small_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/better_call_saul_small.jpg", remote_large_cover_url: "https://s3-eu-west-1.amazonaws.com/myflix112015/uploads/seed/better_call_saul.jpg", category_id: 1)

admin = User.create(full_name: "Admin Dude", password: "hello", email: "admin@domain.com", admin: true)
bob = User.create(full_name: "Bob Meister", password: "hello", email: "email@domain.com")
john = User.create(full_name: "John Doe", password: "hello", email: "john@domain.com")

Review.create(user: bob, video: monk, rating: 5, content: "This is a good show.")
Review.create(user: bob, video: monk, rating: 2, content: "This show is not so good.")