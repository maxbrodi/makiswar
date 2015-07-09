# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


World.create(name: "Forest", description: "Un monde cool", background: "lorem", max_x: 20, max_y: 20)

ItemType.create(name: "Sword", joke: "En garde chevalier", picture: "sword.png", kind:"Attack", lifetime: 5, consumption: 3, life_impact: 3)
ItemType.create(name: "Fireball", joke: "Une bonne grosse boule", picture: "fireball.png", kind:"Attack", lifetime: 5, consumption: 4, life_impact: 4)
ItemType.create(name: "Skate", joke: "Ride comme Tony Hawk", picture: "skate.png", kind:"Movement", lifetime: 5, consumption: 2)
ItemType.create(name: "UberPop", joke: "Cheap but fun!", picture: "car.png", kind:"Movement", lifetime: 10, consumption: 1)

ItemType.create(name: "Wasabi", joke: "Miam", picture: "lorem", kind:"Healing", lifetime: 1)


Item.create(item_type_id: 5, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 5, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 5, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 5, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 5, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 5, world_id: 1, x: 10, y: 11)

Item.create(item_type_id: 4, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 4, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 4, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 4, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 4, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 4, world_id: 1, x: 10, y: 11)

Item.create(item_type_id: 3, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 3, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 3, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 3, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 3, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 3, world_id: 1, x: 10, y: 11)

Item.create(item_type_id: 2, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 2, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 2, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 2, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 2, world_id: 1, x: 10, y: 11)

Item.create(item_type_id: 1, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 1, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 1, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 1, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 1, world_id: 1, x: 10, y: 11)
