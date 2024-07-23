class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :reservation_date_start, presence: true
  validates :reservation_date_end, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if reservation_date_end.blank? || reservation_date_start.blank?

    if reservation_date_end < reservation_date_start
      errors.add(:reservation_date_end, "Must be after the start date")
    end
  end
end
