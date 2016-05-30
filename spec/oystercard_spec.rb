require 'oystercard'

describe Oystercard do

  before(:each) do
    subject.top_up(Oystercard::MAXIMUM_AMOUNT)
  end

  it 'has a balance of zero' do
    subject.deduct(Oystercard::MAXIMUM_AMOUNT)
    expect(subject.balance).to eq (Oystercard::ZERO_BALANCE)
  end

  describe "#top_up" do

    it "responds to top_up with an argument" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "raises an error if balance goes above £90" do
      expect{ subject.top_up(1) }.to raise_error "Maximum amount is #{Oystercard::MAXIMUM_AMOUNT}"
    end
  end

  describe "#deduct" do

    it "responds to deduct with an argument" do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it "can reduce the balance on the oystercard" do
      expect{ subject.deduct(5) }.to change{subject.balance}.by -5
    end

    it "raises an error if balance goes below zero" do
      expect{ subject.deduct(Oystercard::MAXIMUM_AMOUNT + 1) }.to raise_error "Minimum amount is #{Oystercard::ZERO_BALANCE}"
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

    it "it raies an error if there isn't enough money" do
      subject.deduct(Oystercard::MAXIMUM_AMOUNT)
      expect{ subject.touch_in }.to raise_error "Sorry you need to have a minimum of £1 on your card"
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
