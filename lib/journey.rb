class Journey
  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6
  MIN_FARE = 1

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
    fare
  end

  def fare
    complete? ? MIN_FARE : PENALTY_FARE

  end

  def in_journey?
    @entry_station && !@exit_station
  end

  private

  def complete?
    !!@entry_station && !!@exit_station
  end

end
