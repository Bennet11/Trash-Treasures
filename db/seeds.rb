User.destroy_all
Post.destroy_all
Category.destroy_all

5.times do
  u = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  u.skip_confirmation!
  u.save
end

users = User.all

5.times do
  Category.create(
    name: Faker::Commerce.department
  )
end

10.times do
  Post.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    number: Faker::PhoneNumber.cell_phone,
    user:  users.sample,
    price: rand(1..100),
    category_id: rand(1..5),
    image_file_name: Faker::Placeholdit.image
  )
end
