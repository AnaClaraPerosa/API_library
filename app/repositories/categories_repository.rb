class CategoriesRepository
  CACHE_KEY = "categories_cache"

  def initialize(relation = Category.all)
    @relation = relation
  end

  def find_all
    Rails.cache.fetch(CACHE_KEY, expires: 12.hours) do
      @relation.map { |category| serialize(category) }
    end  
  end

  def find_by_id(id)
    category = @relation.find(id)
    serialize(category)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def create(attributes)
    category = Category.create!(attributes)
    expire_cache
    serialize(category)
  end

  def update(category, attributes)
    category.update!(attributes)
    expire_cache
    serialize(category)
  end

  def destroy(category)
    category.destroy!
    expire_cache
    serialize(category)
  end

  private

  def serialize(category)
    CategorySerializer.new(category).as_json
  end

  def expire_cache
    Rails.cache.delete(CACHE_KEY)
  end
end
