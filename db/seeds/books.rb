50.times do
  Book.create!(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph,
    author: Author.order('RANDOM()').first,
    category: Category.order('RANDOM()').first
  )
end
