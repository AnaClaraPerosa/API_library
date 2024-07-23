class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author_id, :category_id, :created_at, :updated_at

  belongs_to :author
  belongs_to :category
end
