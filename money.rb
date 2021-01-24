class Money
  MONEY = [10, 50, 100, 500, 1000].freeze
  def self.is_valid(money)
    if MONEY.include?(money)
      return true
    end
  end
end
