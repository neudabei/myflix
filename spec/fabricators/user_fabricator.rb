Fabricator(:user) do
  email { Faker::Internet.email }
  password 'password'
  full_name { Faker::Name.name }
  admin false
end

Fabricator(:admin, from: :user) do # this fabricator inherits from the user fabricator above
  admin true
end