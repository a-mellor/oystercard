class Oystercard

  attr_reader :balance
  attr_accessor :in_journey, :entry_station, :exit_station

  MAXIMUM_AMOUNT = 90
  MINUMUM_AMOUNT = 1
  ZERO_BALANCE = 0
  MINIMUM_FARE = 2

  def initialize
    @balance = 0
    @entry_station = entry_station
    @exit_station = exit_station
    @history = {}
  end

  def top_up(amount)
    raise "Maximum amount is #{MAXIMUM_AMOUNT}" if amount + balance > MAXIMUM_AMOUNT
    @balance += amount
  end


  def touch_in(station)
    raise "Sorry you need to have a minimum of £1 on your card" if balance < MINUMUM_AMOUNT
    @entry_station = station
    # @exit_station = nil
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    # @entry_station = nil
    @exit_station = station
    journey_history
  end

  def in_journey?
    !!entry_station
  end

  def journeys
    @history
  end

  private

  def deduct(amount)
    raise "Minimum amount is #{ZERO_BALANCE}" if balance - amount < ZERO_BALANCE
    @balance -= amount
  end

  def journey_history
    @history[entry_station] = exit_station
    @entry_station = nil
    @exit_station = nil
  end
end
