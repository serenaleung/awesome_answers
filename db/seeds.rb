# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Subject.create(
[
  {name: 'Science'},
  {name: 'Metal'},
  {name: 'Bad Ass'},
  {name: 'Prose'},
  {name: 'Memes'},
  {name: 'Pop'},
]
)

subjects = Subject.all

200.times do
  Question.create({ title: Faker::Hacker.say_something_smart,
                    body:  Faker::Hipster.paragraph,
                    view_count: rand(1000),
                    subject: subjects.sample
                  })
end

questions = Question.all

questions.each do |q|
  rand(0..10).times do
    q.answers.create({
      body: Faker::RickAndMorty.quote
      })
  end
end

answers_count = Answer.count


puts Cowsay.say "Created #{answers_count} answers", :ghostbusters

puts Cowsay.say 'Created 1000 questions', :cow
