class Oystercard

  attr_reader :balance
  attr_accessor :in_journey

  MAXIMUM_AMOUNT = 90
  ZERO_BALANCE = 0

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum amount is #{MAXIMUM_AMOUNT}" if amount + balance > MAXIMUM_AMOUNT
    @balance += amount
  end

  def deduct(amount)
    raise "Minimum amount is #{ZERO_BALANCE}" if balance - amount < ZERO_BALANCE
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
