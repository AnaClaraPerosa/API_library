class LoanSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :book_id, :loan_date_start, :loan_date_end, :created_at, :updated_at

  belongs_to :user
  belongs_to :book
end
