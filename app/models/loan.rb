class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :loan_date_start, presence: true
  validates :loan_date_end, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if loan_date_end.blank? || loan_date_start.blank?

    if loan_date_end < loan_date_start
      errors.add(:loan_date_end, "Must be after the start date")
    end
  end
end
