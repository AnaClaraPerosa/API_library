5.times do
  Category.create!(
    name: Faker::Book.genre
  )
end
