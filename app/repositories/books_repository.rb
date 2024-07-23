class BooksRepository
  CACHE_KEY = "books_cache"

  def initialize(relation = Book.all)
    @relation = relation
  end

  def find_all
    Rails.cache.fetch(CACHE_KEY, expires_in: 12.hours) do
      @relation.map { |book| serialize(book) }
    end
  end

  def find_by_id(id)
    book = @relation.find(id)
    serialize(book)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def create(attributes)
    book = Book.create!(attributes)
    expire_cache
    serialize(book)
  end

  def update(book, attributes)
    book.update!(attributes)
    expire_cache
    serialize(book)
  end

  def destroy(book)
    book.destroy!
    expire_cache
    serialize(book)
  end

  private

  def serialize(book)
    BookSerializer.new(book).as_json
  end

  def expire_cache
    Rails.cache.delete(CACHE_KEY)
  end
end
