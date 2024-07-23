class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :book_id, :reservation_date_start, :reservation_date_end, :created_at, :updated_at

  belongs_to :user
  belongs_to :book
end
