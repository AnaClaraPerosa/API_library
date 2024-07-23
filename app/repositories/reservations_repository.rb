class ReservationsRepository
  CACHE_KEY = "reservations_cache"

  def initialize(relation = Reservation.all)
    @relation = relation
  end

  def find_all
    Rails.cache.fetch(CACHE_KEY, expires_in: 12.hours) do
      @relation.map { |reservation| serialize(reservation) }
    end
  end

  def find_by_id(id)
    reservation = @relation.find(id)
    serialize(reservation)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def create(attributes)
    reservation = Reservation.create!(attributes)
    expire_cache
    serialize(reservation)
  end

  def update(reservation, attributes)
    reservation.update!(attributes)
    expire_cache
    serialize(reservation)
  end

  def destroy(reservation)
    reservation.destroy!
    expire_cache
    serialize(reservation)
  end

  private

  def serialize(reservation)
    ReservationSerializer.new(reservation).as_json
  end

  def expire_cache
    Rails.cache.delete(CACHE_KEY)
  end
end
