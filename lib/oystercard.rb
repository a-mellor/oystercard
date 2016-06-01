class Oystercard

  attr_reader :balance, :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Balance can't exceed 90" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Already in a journey" if in_journey?
    raise "Not enough funds" if balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    raise "Not yet started journey" unless in_journey?
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
