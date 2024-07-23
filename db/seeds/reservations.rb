20.times do
  Reservation.create!(
    user: User.order('RANDOM()').first,
    book: Book.order('RANDOM()').first,
    reservation_date_start: Faker::Date.backward(days: 14),
    reservation_date_end: Faker::Date.forward(days: 14)
  )
end
