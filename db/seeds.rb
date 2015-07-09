# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# World.create(name: "Forest", description: "Un monde cool", background: "lorem", max_x: 20, max_y: 20)

# WEAPONS

ItemType.create(name: "Valyrian Sword", joke: "Careful, Your Grace. Nothing cuts like Valyrian steel.", picture: "sword.png", kind:"Attack", lifetime: 10, consumption: 3, life_impact: 4)
ItemType.create(name: "Baseball Bat", joke: "Favourite weapon of the Batman.", picture: "baseballbat.png", kind:"Attack", lifetime: 10, consumption: 3, life_impact: 2)
ItemType.create(name: "Cocktail Poliakov", joke: "Hurts your opponent right in the liver.", picture: "cocktailpoliakof.png", kind:"Attack", lifetime: 10, consumption: 2, life_impact: 1)
ItemType.create(name: "Banana Snake", joke: "Half banana, half snake, half awesome.", picture: "bananasnake.png", kind:"Attack", lifetime: 10, consumption: 2, life_impact: 2)

# TRANSPORT TYPES

ItemType.create(name: "Skate", joke: "Ride like Tuna Hawk.", picture: "skate.png", kind:"Movement", lifetime: 10, consumption: 3)
ItemType.create(name: "UberPop", joke: "Still not forbidden in here.", picture: "uberpop.png", kind:"Movement", lifetime: 10, consumption: 2)
ItemType.create(name: "Rainbow Unicorn", joke: "You look fabulous on it.", picture: "unicorn.png", kind:"Movement", lifetime: 10, consumption: 2)
ItemType.create(name: "Hyperloop", joke: "You\'ve never moved that fast to the next cell.", picture: "hyperloop.png", kind:"Movement", lifetime: 10, consumption: 1)


# (1...6).each do |i|
(14...19).each do |i|
  10.times do
    x_rand = rand(21)
    y_rand = rand(21)
    Item.create(item_type_id: i, world_id: 1, x: x_rand, y: y_rand)
  end
end

# (7...8).each do |i|
(20...21).each do |i|
  2.times do
    x_rand = rand(21)
    y_rand = rand(21)
    Item.create(item_type_id: i, world_id: 1, x: x_rand, y: y_rand)
  end
end

