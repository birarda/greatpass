# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Toppers
toppers = [
  { name: 'Bobby Helmet' },
  { name: 'Brünnehilde' },
  { name: 'Cherry Top' },
  { name: 'Devil Horns' },
  { name: 'Fez' },
  { name: 'Fire Helmet' },
  { name: 'Gold Cap', rarity: Item.rarities[:limited] },
  { name: 'Halo' },
  { name: 'Hard Hat' },
  { name: 'Mariachi Hat' },
  { name: 'Pirate\'s Hat' },
  { name: 'Pizza Topper' },
  { name: 'Propellerhead' },
  { name: 'Royal Crown' },
  { name: 'Sombrero' },
  { name: 'Taxi Topper' },
  { name: 'Top Hat' },
  { name: 'Witch\'s Hat' },
  { name: 'Wizard Hat' },
  # { name: 'Cavalier', rarity: Item.rarities[:premium] },
  # { name: 'Locomotive', rarity: Item.rarities[:premium] },
  # { name: 'Pixelated Shades', rarity: Item.rarities[:premium] },
  # { name: 'Shark Fin', rarity: Item.rarities[:premium] },
  # { name: 'Pumpkin', rarity: Item.rarities[:limited] },
  # { name: 'Boombox', rarity: Item.rarities[:premium] },
  # { name: 'Cow Skull', rarity: Item.rarities[:premium] },
  # { name: 'Mohawk', rarity: Item.rarities[:premium] },
  { name: 'Blitzen', rarity: Item.rarities[:limited] },
  { name: 'Christmas Tree', rarity: Item.rarities[:limited] },
  { name: 'Sad Sapling', rarity: Item.rarities[:limited] },
  { name: 'Santa', rarity: Item.rarities[:limited] },
  { name: 'Unicorn', rarity: Item.rarities[:uncommon] },
  { name: 'Traffic Cone', rarity: Item.rarities[:uncommon] },
  { name: 'Tiara', rarity: Item.rarities[:uncommon] },
  { name: 'Shuriken', rarity: Item.rarities[:uncommon] },
  { name: 'Rhino Horns', rarity: Item.rarities[:uncommon] },
  { name: 'Mouse Trap', rarity: Item.rarities[:uncommon] },
  { name: 'Rasta', rarity: Item.rarities[:uncommon] },
  { name: 'Police Hat', rarity: Item.rarities[:uncommon] },
  { name: 'Plunger', rarity: Item.rarities[:uncommon] },
  { name: 'Paper Boat', rarity: Item.rarities[:uncommon] },
  { name: 'Gradutation Cap', rarity: Item.rarities[:uncommon] },
  { name: 'Bowler', rarity: Item.rarities[:uncommon] },
  { name: 'Fruit Hat', rarity: Item.rarities[:uncommon] },
  { name: 'Brodie Helmet', rarity: Item.rarities[:uncommon] },
  { name: 'Homburg', rarity: Item.rarities[:uncommon] },
  { name: 'Brown Derby', rarity: Item.rarities[:uncommon] },
  { name: 'Deerstalker', rarity: Item.rarities[:uncommon] },
  { name: 'Deadmau5 (Topper)', rarity: Item.rarities[:uncommon] },
  { name: 'Cockroach', rarity: Item.rarities[:uncommon] },
  { name: 'Chef\'s Hat', rarity: Item.rarities[:uncommon] },
  { name: 'Chainsaw', rarity: Item.rarities[:uncommon] },
  { name: 'Captain\'s Hat', rarity: Item.rarities[:uncommon] },
  { name: 'Work Boot', rarity: Item.rarities[:uncommon] },
  { name: 'Birthday Cake', rarity: Item.rarities[:uncommon] },
  { name: 'Biker Cap', rarity: Item.rarities[:uncommon] },
  { name: 'Red Beret', rarity: Item.rarities[:uncommon] },
  { name: 'Antlers', rarity: Item.rarities[:uncommon] },
  { name: 'Season 1 - Bronze', rarity: Item.rarities[:limited] },
  { name: 'Season 1 - Silver', rarity: Item.rarities[:limited] },
  { name: 'Season 1 - Gold', rarity: Item.rarities[:limited] },
  { name: 'Season 1 - Platinum', rarity: Item.rarities[:limited] },
  { name: 'Robo-Visor', rarity: Item.rarities[:rare] },
  { name: 'Wildcat Ears', rarity: Item.rarities[:rare] },
  { name: 'Drink Helmet', rarity: Item.rarities[:rare] },
  { name: 'Pigeon', rarity: Item.rarities[:uncommon] },
  { name: 'Bow', rarity: Item.rarities[:uncommon] },
  { name: 'Cowboy Hat', rarity: Item.rarities[:uncommon] },
  { name: 'Flat Hat', rarity: Item.rarities[:uncommon] },
  { name: 'Golf Hat', rarity: Item.rarities[:uncommon] },
  { name: 'Light Bulb', rarity: Item.rarities[:uncommon] },
  { name: 'Party Hat', rarity: Item.rarities[:uncommon] },
  { name: 'Trucker Hat', rarity: Item.rarities[:uncommon] },
  { name: 'Visor', rarity: Item.rarities[:uncommon] },
  { name: 'White Hat', rarity: Item.rarities[:uncommon] },
  { name: 'Baseball Cap [F]', rarity: Item.rarities[:uncommon] },
  { name: 'Baseball Cap [B]', rarity: Item.rarities[:uncommon] },
]

toppers.each do |topper_attrs|
  Item.find_or_create_by(topper_attrs)
end

# Antennas

antennas = [
  { name: 'Gold Nugget', rarity: Item.rarities[:limited], kind: Item.kinds[:antenna] },
  { name: 'Candy Cane', rarity: Item.rarities[:limited], kind: Item.kinds[:antenna] },
  { name: 'Holiday Gift', rarity: Item.rarities[:limited], kind: Item.kinds[:antenna] },
  { name: 'Rainbow Flag', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Waffle', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Rubber Duckie', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Rocket', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Piñata', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Parrot', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Moai', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Deadmau5 (Antenna)', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Hula Girl', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Genie Lamp', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Foam Finger', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Venus Flytrap', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Sunflower', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Rose', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Donut', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Balloon Dog', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Disco Ball', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Cupcake', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Chick Magnet', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Candle', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] },
  { name: 'Alien', rarity: Item.rarities[:uncommon], kind: Item.kinds[:antenna] }
]

antennas.each do |antenna_attrs|
  Item.find_or_create_by(antenna_attrs)
end

# Wheels

wheels = [
  { name: 'Sunburst', rarity: Item.rarities[:uncommon], kind: Item.kinds[:wheels] },
  { name: 'Trahere', rarity: Item.rarities[:uncommon], kind: Item.kinds[:wheels] },
  { name: 'Rat Rod', rarity: Item.rarities[:uncommon], kind: Item.kinds[:wheels] },
  { name: 'Tunica', rarity: Item.rarities[:uncommon], kind: Item.kinds[:wheels] },
  { name: 'Lowrider', rarity: Item.rarities[:uncommon], kind: Item.kinds[:wheels] }
]

wheels.each do |wheel_attrs|
  Item.find_or_create_by(wheel_attrs)
end

# Boosts

boosts = [
  { name: 'Candy Corn', rarity: Item.rarities[:limited], kind: Item.kinds[:boost] },
  { name: 'Xmas', rarity: Item.rarities[:limited], kind: Item.kinds[:boost] },
  { name: 'Season 2 - Challenger', rarity: Item.rarities[:limited], kind: Item.kinds[:boost] },
  { name: 'Season 2 - Prospect', rarity: Item.rarities[:limited], kind: Item.kinds[:boost] },
  { name: 'Season 2 - Star', rarity: Item.rarities[:limited], kind: Item.kinds[:boost] },
  { name: 'Season 2 - Champion', rarity: Item.rarities[:limited], kind: Item.kinds[:boost] },
  { name: 'Toon Smoke', rarity: Item.rarities[:super_rare], kind: Item.kinds[:boost] },
  { name: 'Frostbite', rarity: Item.rarities[:super_rare], kind: Item.kinds[:boost] },
  { name: 'Hearts', rarity: Item.rarities[:super_rare], kind: Item.kinds[:boost] },
  { name: 'Lightning', rarity: Item.rarities[:super_rare], kind: Item.kinds[:boost] },
]

boosts.each do |boost_attrs|
  Item.find_or_create_by(boost_attrs)
end

# Decals

decals = [
  { name: 'Junk Food (Breakout)', rarity: Item.rarities[:rare], kind: Item.kinds[:decal] },
  { name: 'Racer (Octane)', rarity: Item.rarities[:rare], kind: Item.kinds[:decal] },
  { name: 'Flex (Venom)', rarity: Item.rarities[:rare], kind: Item.kinds[:decal] },
  { name: 'Royalty (Dominus)', rarity: Item.rarities[:rare], kind: Item.kinds[:decal] }
]

decals.each do |decal_attrs|
  Item.find_or_create_by(decal_attrs)
end
