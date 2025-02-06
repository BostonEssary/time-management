# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Cleaning the database..."
# Delete all records in reverse order to handle dependencies
Rating.delete_all
Follow.delete_all
ProductEffect.delete_all
Effect.delete_all
PreRoll.delete_all
Concentrate.delete_all
Edible.delete_all
Flower.delete_all
Brand.delete_all
User.delete_all

puts "Creating users..."
users = []
10.times do |i|
  users << User.create!(
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: 'password123',  # Simple password for development
    date_of_birth: Faker::Date.birthday(min_age: 21, max_age: 65),
    experience_level: User::EXPERIENCE_LEVELS.sample,
    consumption_preferences: User::CONSUMPTION_METHODS.sample(rand(1..3))
  )
end

puts "Creating brands..."
brands = []
5.times do
  brands << Brand.create!(
    name: Faker::Company.unique.name
  )
end

puts "Creating effects..."
effects = []
effect_names = [
  "Relaxed", "Euphoric", "Happy", "Uplifted", "Sleepy",
  "Focused", "Creative", "Energetic", "Hungry", "Talkative"
]

effect_names.each do |name|
  effects << Effect.create!(
    name: name,
    description: Faker::Lorem.sentence(word_count: 10)
  )
end

puts "Creating flowers..."
flowers = []
15.times do
  flower = Flower.new(
    brand: brands.sample,
    name: Faker::Cannabis.unique.strain,
    strain: Flower::STRAINS.sample,
    thc: Faker::Number.between(from: 14.0, to: 35.0).round(1)
  )
  
  # Attach avatar and images
  flower.avatar.attach(
    io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
    filename: 'test_image.jpg',
    content_type: 'image/jpeg'
  )
  
  2.times do
    flower.images.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )
  end
  
  flower.save!
  flowers << flower
  
  # Add 2-4 random effects for each flower
  effects.sample(rand(2..4)).each do |effect|
    ProductEffect.create!(
      effectable: flower,
      effect: effect
    )
  end
end

puts "Creating concentrates..."
concentrates = []
10.times do
  concentrate = Concentrate.new(
    brand: brands.sample,
    name: "#{Faker::Cannabis.unique.strain} #{Concentrate::CATEGORIES.sample}",
    strain: Flower::STRAINS.sample,
    category: Concentrate::CATEGORIES.sample,
    thc: Faker::Number.between(from: 60.0, to: 95.0).round(1)
  )
  
  # Attach avatar and images
  concentrate.avatar.attach(
    io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
    filename: 'test_image.jpg',
    content_type: 'image/jpeg'
  )
  
  2.times do
    concentrate.images.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )
  end
  
  concentrate.save!
  concentrates << concentrate
  
  # Add 2-4 random effects for each concentrate
  effects.sample(rand(2..4)).each do |effect|
    ProductEffect.create!(
      effectable: concentrate,
      effect: effect
    )
  end
end

puts "Creating pre-rolls..."
pre_rolls = []
8.times do
  pre_roll = PreRoll.new(
    brand: brands.sample,
    name: "#{Faker::Cannabis.unique.strain} Pre-Roll",
    strain: Flower::STRAINS.sample,
    thc: Faker::Number.between(from: 15.0, to: 35.0).round(1),
    infused: [true, false].sample
  )
  
  # Attach avatar and images
  pre_roll.avatar.attach(
    io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
    filename: 'test_image.jpg',
    content_type: 'image/jpeg'
  )
  
  2.times do
    pre_roll.images.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )
  end
  
  pre_roll.save!
  pre_rolls << pre_roll
  
  # Add 2-4 random effects for each pre-roll
  effects.sample(rand(2..4)).each do |effect|
    ProductEffect.create!(
      effectable: pre_roll,
      effect: effect
    )
  end
end

puts "Creating edibles..."
food_types = ["Gummy", "Chocolate", "Brownie", "Cookie", "Drink", "Hard Candy"]
edibles = []
12.times do
  edible = Edible.new(
    brand: brands.sample,
    name: "#{Faker::Cannabis.unique.strain} #{food_types.sample}",
    strain: Flower::STRAINS.sample,
    food_type: food_types.sample,
    mg_per_serving: [5, 10, 20, 50, 100].sample
  )
  
  # Attach avatar and images
  edible.avatar.attach(
    io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
    filename: 'test_image.jpg',
    content_type: 'image/jpeg'
  )
  
  2.times do
    edible.images.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )
  end
  
  edible.save!
  edibles << edible
  
  # Add 2-4 random effects for each edible
  effects.sample(rand(2..4)).each do |effect|
    ProductEffect.create!(
      effectable: edible,
      effect: effect
    )
  end
end

puts "Creating ratings..."
# Create some ratings for each product type
all_products = flowers + concentrates + pre_rolls + edibles
all_products.each do |product|
  rand(3..8).times do
    Rating.create!(
      ratable: product,
      score: rand(60..100)  # Assuming ratings from 60-100 for a positive skew
    )
  end
end

puts "Creating follows..."
# Create some follow relationships between users
users.each do |user|
  # Each user follows 1-5 other random users
  users.reject { |u| u == user }.sample(rand(1..5)).each do |followee|
    Follow.create!(
      follower: user,
      followee: followee
    )
  end
end

puts "Seeding completed!"
