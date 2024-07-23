20.times do
  Loan.create!(
    user: User.order('RANDOM()').first,
    book: Book.order('RANDOM()').first,
    loan_date_start: Faker::Date.backward(days: 30),
    loan_date_end: Faker::Date.forward(days: 30)
  )
end
