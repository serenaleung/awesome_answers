# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1000.times do
  Question.create({ title: Faker::Hacker.say_something_smart,
                    body:  Faker::Hipster.paragraph,
                    view_count: rand(1000)
                  })
end

puts Cowsay.say 'Created 1000 questions', :cow
