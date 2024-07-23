class LoansRepository
  CACHE_KEY = "loans_cache"

  def initialize(relation = Loan.all)
    @relation = relation
  end

  def find_all
    Rails.cache.fetch(CACHE_KEY, expires_in: 12.hours) do
      @relation.map { |loan| serialize(loan) }
    end
  end

  def find_by_id(id)
    loan = @relation.find(id)
    serialize(loan)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def create(attributes)
    loan = Loan.create!(attributes)
    expire_cache
    serialize(loan)
  end

  def update(loan, attributes)
    loan.update!(attributes)
    expire_cache
    serialize(loan)
  end

  def destroy(loan)
    loan.destroy!
    expire_cache
    serialize(loan)
  end

  private

  def serialize(loan)
    LoanSerializer.new(loan).as_json
  end

  def expire_cache
    Rails.cache.delete(CACHE_KEY)
  end
end
