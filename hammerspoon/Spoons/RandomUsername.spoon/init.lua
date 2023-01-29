--- === RandomUsername ===

nouns = { "Actor", "Gold", "Painting", "Advertisement", "Grass", "Parrot", "Afternoon", "Greece", "Pencil", "Airport",
  "Guitar", "Piano", "Ambulance", "Hair", "Pillow", "Animal", "Hamburger", "Pizza", "Answer", "Helicopter", "Planet",
  "Apple", "Helmet", "Plastic", "Army", "Holiday", "Portugal", "Australia", "Honey", "Potato", "Balloon", "Horse",
  "Queen", "Banana", "Hospital", "Quill", "Battery", "House", "Rain", "Beach", "Hydrogen", "Rainbow", "Beard", "Ice",
  "Raincoat", "Bed", "Insect", "Refrigerator", "Belgium", "Insurance", "Restaurant", "Boy", "Iron", "River", "Branch",
  "Island", "Rocket", "Breakfast", "Jackal", "Room", "Brother", "Jelly", "Rose", "Camera", "Jewellery", "Russia",
  "Candle", "Jordan", "Sandwich", "Car", "Juice", "School", "Caravan", "Kangaroo", "Scooter", "Carpet", "King", "Shampoo",
  "Cartoon", "Kitchen", "Shoe", "China", "Kite", "Soccer", "Church", "Knife", "Spoon", "Crayon", "Lamp", "Stone", "Crowd",
  "Lawyer", "Sugar", "Daughter", "Leather", "Sweden", "Death", "Library", "Teacher", "Denmark", "Lighter", "Telephone",
  "Diamond", "Lion", "Television", "Dinner", "Lizard", "Tent", "Disease", "Lock", "Thailand", "Doctor", "London",
  "Tomato", "Dog", "Lunch", "Toothbrush", "Dream", "Machine", "Traffic", "Dress", "Magazine", "Train", "Easter",
  "Magician", "Truck", "Egg", "Manchester", "Uganda", "Eggplant", "Market", "Umbrella", "Egypt", "Match", "Van",
  "Elephant", "Microphone", "Vase", "Energy", "Monkey", "Vegetable", "Engine", "Morning", "Vulture", "England",
  "Motorcycle", "Wall", "Evening", "Nail", "Whale", "Eye", "Napkin", "Window", "Family", "Needle", "Wire", "Finland",
  "Nest", "Fish", "Nigeria", "Yacht", "Flag", "Night", "Yak", "Flower", "Notebook", "Zebra", "Football", "Ocean", "Zoo",
  "Forest", "Oil", "Garden", "Fountain", "Orange", "Gas", "France", "Oxygen", "Girl", "Furniture", "Oyster", "Glass",
  "Garage", "Ghost" }

local obj = {}
obj.__index = obj

obj.name = "RandomUsername"
obj.version = "1.0"
obj.author = "David Mohl"

--- RandomUsername:generateUsername()
--- Method
--- Generate random username
---
--- Parameters:
---  * None
---
--- Returns:
---  * A string
function obj:generateUsername()
  first = nouns[math.random(#nouns)]
  second = nouns[math.random(#nouns)]

  return first .. second
end

return obj
