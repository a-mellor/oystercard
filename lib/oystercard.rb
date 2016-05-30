class Oystercard

  attr_reader :balance
  attr_writer :amount

  def initialize
    @balance = 0
    @amount = amount
  end

  def top_up(amount)
    @balance + amount
  end


end
