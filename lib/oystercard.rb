require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90


  attr_reader :balance, :journeys

  def initialize
    @balance = 0
    @journeys = {}
  end

  def touch_in(station)
    no_touch_out if !!current_journey
    balance_check
    successful_touch_in(station)
  end

  def touch_out(station)
    current_journey == nil ? no_touch_in(station) : successful_touch_out(station)
  end

  def top_up(amount)
    max_balance_check(amount)
    @balance = balance + amount
  end

  private

  attr_accessor :current_journey
  attr_writer :balance

  def deduct(amount)
    @balance -= amount
  end

  def no_touch_out
    deduct(current_journey.fare)
  end

  def no_touch_in(station)
    journey = Journey.new
    journey.start(nil)
    journey.finish(station)
    deduct(journey.fare)
  end

  def balance_check
  fail "Error: minimum balance less than minimum fare. Top-up!" if @balance < Journey::MIN_FARE
  end

  def successful_touch_in(station, journey = Journey.new)
    @current_journey = journey
    current_journey.start(station)
  end

  def successful_touch_out(station)
    deduct(current_journey.finish(station))
    @current_journey = nil
  end

  def max_balance_check(amount)
    fail "Maximum balance of #{MAX_BALANCE} reached!" if balance + amount > MAX_BALANCE
  end
end
