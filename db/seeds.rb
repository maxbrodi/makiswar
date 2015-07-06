# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


World.create(name: "Forest", description: "Un monde cool", background: "lorem", max_x: 20, max_y: 20)

ItemType.create(name: "Sword", joke: "En garde chevalier", picture: "lorem", kind:"Attack", lifetime: 10, consumption: 5, life_impact: 3)
ItemType.create(name: "Skate", joke: "Ride comme Tony Hawk", picture: "lorem", kind:"Movement", lifetime: 5, consumption: 2)
ItemType.create(name: "Wasabi", joke: "Miam", picture: "lorem", kind:"Healing", lifetime:1)

Item.create(item_type_id: 1, world_id: 1, x: 10, y: 11)
Item.create(item_type_id: 1, world_id: 1, x: 6, y: 19)
Item.create(item_type_id: 1, world_id: 1, x: 3, y: 11)
Item.create(item_type_id: 1, world_id: 1, x: 12, y: 10)
Item.create(item_type_id: 1, world_id: 1, x: 6, y: 8)

Item.create(item_type_id: 2, world_id: 1, x: 9, y: 11)
Item.create(item_type_id: 2, world_id: 1, x: 6, y: 20)
Item.create(item_type_id: 2, world_id: 1, x: 3, y: 14)
Item.create(item_type_id: 2, world_id: 1, x: 12, y: 17)
Item.create(item_type_id: 2, world_id: 1, x: 6, y: 17)

Item.create(item_type_id: 3, world_id: 1, x: 10, y: 1)
Item.create(item_type_id: 3, world_id: 1, x: 6, y: 15)
Item.create(item_type_id: 3, world_id: 1, x: 3, y: 3)
Item.create(item_type_id: 3, world_id: 1, x: 14, y: 10)
Item.create(item_type_id: 3, world_id: 1, x: 14, y: 1)
