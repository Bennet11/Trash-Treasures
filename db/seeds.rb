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

  categories = Category.all

DEFAULT_IMAGE_PATH = File.join(Rails.root, 'app/assets/images/default.png')

10.times do
  Post.create!(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    number: Faker::PhoneNumber.cell_phone,
    user:  users.sample,
    price: rand(1..100),
    category: categories.sample,
    image: File.new(DEFAULT_IMAGE_PATH)
  )
end
