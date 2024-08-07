require "faker"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Fill the DB with some instances we can use
puts "Cleaning the DB..."
Restaurant.destroy_all

# CATEGORIES = %W[burger ramen sushi desserts healthy kebabs pizza tacos sandwiches dumplings soup curry rice pasta steakhouse vegan bakery juice salads seafood brunch wings cafe bbq deli pies buffet pub brasserie shakes creamery grill]

restaurant_amount = 10

puts "Creating #{restaurant_amount} Restaurants..."

restaurant_amount.times do
  restaurant = Restaurant.new(
    name: Faker::Restaurant.unique.name,
    address: Faker::Address.street_address,
    category: Restaurant::CATEGORIES.sample
  )

  Review.create!(content: Faker::Restaurant.review, rating: rand(2..5), restaurant: restaurant)

  restaurant.save
end

puts "... created #{restaurant_amount} restaurants"
