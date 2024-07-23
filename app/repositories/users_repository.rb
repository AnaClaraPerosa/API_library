class UsersRepository
  CACHE_KEY = "users_cache"

  def initialize(relation = User.all)
    @relation = relation
  end

  def find_all
    Rails.cache.fetch(CACHE_KEY, expires_in: 12.hours) do
      @relation.map { |user| serialize(user) }
    end
  end

  def find_by_id(id)
    user = @relation.find(id)
    serialize(user)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def create(attributes)
    user = User.create!(attributes)
    expire_cache
    serialize(user)
  end

  def update(user, attributes)
    user.update!(attributes)
    expire_cache
    serialize(user)
  end

  def destroy(user)
    user.destroy!
    expire_cache
    serialize(user)
  end

  private

  def serialize(user)
    UserSerializer.new(user).as_json
  end

  def expire_cache
    Rails.cache.delete(CACHE_KEY)
  end
end
