class Oystercard

  attr_reader :balance
  MAXIMUM_AMOUNT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum amount is #{MAXIMUM_AMOUNT}" if amount + balance > MAXIMUM_AMOUNT
    @balance += amount
  end


end
