require 'oystercard'

describe Oystercard do

  before(:each) do
    subject.top_up(Oystercard::MAXIMUM_AMOUNT)
  end

  let(:start_station) {double :station}
  let(:finish_station) {double :station}

  describe "#top_up" do

    it "responds to top_up with an argument" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "raises an error if balance goes above £90" do
      expect{ subject.top_up(1) }.to raise_error "Maximum amount is #{Oystercard::MAXIMUM_AMOUNT}"
    end
  end

  describe "#touch_in" do

    it "responds to touch_in" do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it "updates the status of the journey to touch in" do
      subject.touch_in(start_station)
      expect(subject.in_journey?).to eq true
    end

    it "stores entry station" do
      subject.touch_in(start_station)
      expect(subject.entry_station).to eq start_station
    end
  end

  describe "#touch_out" do

    it "responds to touch_out" do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    it "updates the status of the journey to touch out" do
      subject.touch_in(start_station)
      subject.touch_out(finish_station)
      expect(subject.in_journey?).to eq false
    end

    it "deducts a fare when touching out" do
      subject.touch_in(start_station)
      expect{ subject.touch_out(finish_station) }.to change{ subject.balance}.by -(Oystercard::MINIMUM_FARE)
    end

    it "stores an exit station" do
      subject.touch_in(start_station)
      subject.touch_out(finish_station)
      expect(subject.exit_station).to eq finish_station
    end
  end

  describe "#in_journey?" do

    it "responds to in_journey?" do
      expect(subject).to respond_to(:in_journey?)
    end
  end

  describe "#journey_history" do

    it "responds to journey_history" do
      expect(subject).to respond_to(:journey_history)
    end

    it "stores previous journeys" do
      expect(subject.journey_history).should include(start_station, finish_station)

    end

  end

end
