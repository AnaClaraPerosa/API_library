5.times do
  Author.create!(
    name: Faker::Book.author
  )
end
