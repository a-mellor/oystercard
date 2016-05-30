require 'oystercard'

describe Oystercard do

  it 'has a balance of zero' do
    expect(subject.balance).to eq (0)
  end

  describe "#top_up" do

    it "responds to top_up with an argument" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "allows money to be put on the oystercard" do
      amount = 10
      expect(subject.top_up(amount)).to eq 10
    end

    it "raises an error if balance goes above £90" do
      subject.top_up(Oystercard::MAXIMUM_AMOUNT)
      expect{ subject.top_up(1) }.to raise_error "Maximum amount is #{Oystercard::MAXIMUM_AMOUNT}"
    end
  end

  describe "#deduct" do

    it "responds to deduct with an argument" do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it "can reduce the balance on the oystercard" do
      subject.top_up(10)
      expect{ subject.deduct(5) }.to change{subject.balance}.by -5
    end

    it "raises an error if balance goes below zero" do
      expect{ subject.deduct(1) }.to raise_error "Minimum amount is #{Oystercard::ZERO_BALANCE}"
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
  end

  describe "#in_journey?" do

    it "responds to in_journey?" do
      expect(subject).to respond_to(:in_journey?)
    end
  end

end
