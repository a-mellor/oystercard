require 'oystercard'

describe Oystercard do

  before(:each) do
    subject.top_up(Oystercard::MAXIMUM_AMOUNT)
  end

  let(:station) {double :station}

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
      expect(subject).to respond_to(:touch_in)
    end

    it "updates the status of the journey to touch in" do
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it "stores entry station" do
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe "#touch_out" do

    it "responds to touch_out" do
      expect(subject).to respond_to(:touch_out)
    end

    it "updates the status of the journey to touch out" do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end

    it "deducts a fare when touching out" do
      subject.touch_in
      expect{ subject.touch_out }.to change{ subject.balance}.by -(Oystercard::MINIMUM_FARE)
    end
  end

  describe "#in_journey?" do

    it "responds to in_journey?" do
      expect(subject).to respond_to(:in_journey?)
    end
  end

end
