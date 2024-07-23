class AuthorsRepository
  CACHE_KEY = "authors_cache"

  def initialize(relation = Author.all)
    @relation = relation
  end

  def find_all
    Rails.cache.fetch(CACHE_KEY, expires_in: 12.hours) do
      @relation.map { |author| serialize(author) }
    end
  end

  def find_by_id(id)
    author = @relation.find(id)
    serialize(author)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def create(attributes)
    author = Author.create!(attributes)
    expire_cache
    serialize(author)
  end

  def update(author, attributes)
    author.update!(attributes)
    expire_cache
    serialize(author)
  end

  def destroy(author)
    author.destroy!
    expire_cache
    serialize(author)
  end

  private

  def serialize(author)
    AuthorSerializer.new(author).as_json
  end

  def expire_cache
    Rails.cache.delete(CACHE_KEY)
  end
end
