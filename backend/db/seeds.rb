# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Seeding..."

created_items = Array.new

#Users
user_list = [
    { 
        "username" =>  "alanocturna", 
        "email" => "ricardo_tapia@test.com",
        "image" => "https://source.unsplash.com/featured/?bird,robin,red",
        "password" => 'test123',
        "items" => [
            {
                "title" => "Criminology", 
                "description" => "Plato believed that crime was the result of a lack of education",
                "image" => "",
                "tag_list" => [ "Crime", "Philosophy"]

            },
            {
                "title" => "Robin",
                "image" => "https://source.unsplash.com/featured/?robin,bird",
                "description" => "Robins are one of the first birds to start the dawn chorus and one of the last to stop singing at night",
                "tag_list" => [ "Robin", "Fun Facts", "Animals"]
            }
        ]
    },
    {
        "username" => "murcielago", 
        "email" => "bruno_diaz@test.com",
        "image" => "https://source.unsplash.com/featured/?bats,night",
        "password" => 'test123', 
        "items" => [
            {
                "title" => "Bats",
                "description" => "Bats can live more than 30 years and there only 6 species with completely white fur",
                "image" => "https://source.unsplash.com/featured/?bats",
                "tag_list" => [ "Fun Facts", "Animals"]
            }
        ]
    },
    { 
        "username" => "maravilla", 
        "email" => "diana_perez@test.com",
        "image" => "https://source.unsplash.com/featured/?stars",
        "password" => 'test123', 
        "items" => [], 
        "bio" => "Working at the Smithsonian Institution in Washington, D.C. "
    }
]
user_list.each do |user|
    created_user =  User.create!( 
        username: user["username"],
        email: user["email"],
        password: user["password"],
        bio: user["bio"],
        image: user["image"]
    )
    user["items"].each do |item| #create items for each user
        created_item = Item.create(
            title: item["title"],
            description: item["description"],
            user_id: created_user.id,
            image: item["image"],
            tag_list: item["tag_list"].map { |name| ActsAsTaggableOn::Tag.find_or_create_by!(name: name)}
        )
        created_items.push(created_item)
    end
end

#Favorites
Favorite.create( user_id: User.find_by( email: 'diana_perez@test.com').id, item_id:created_items[2].id )
Favorite.create( user_id: User.find_by( email: 'diana_perez@test.com').id, item_id:created_items[1].id )
Favorite.create( user_id: User.find_by( email: 'ricardo_tapia@test.com').id, item_id:created_items[2].id )

#Follows
Follow.create(followable_id: User.find_by( email: 'diana_perez@test.com').id, follower_id: User.find_by( email: 'ricardo_tapia@test.com').id)
Follow.create(followable_id: User.find_by( email: 'bruno_diaz@test.com').id, follower_id: User.find_by( email: 'ricardo_tapia@test.com').id)

#Comments
comments_list = [
    {
       "body" =>  "They are also omnivorous", 
       "user_id" => User.find_by( email: 'bruno_diaz@test.com').id, 
       "item_id" => created_items[1].id 
    },
    {
        "body" => "Cool", 
        "user_id" => User.find_by( email: 'diana_perez@test.com').id, 
        "item_id" => created_items[2].id
    }
]

comments_list.each do |comment|
    Comment.create!( 
        body: comment["body"],
        user_id: comment["user_id"],
        item_id: comment["item_id"]
    )
end

puts "Seeding done."