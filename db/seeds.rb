10.times do
  u = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  u.skip_confirmation!
  u.save
end

users = User.all

50.times do
  Post.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    number: rand(1..5),
    user:  users.sample,
    price: rand(1..100),
    image_file_name: Faker::Placeholdit.image
  )
end
