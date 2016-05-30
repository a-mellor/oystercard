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
      expect(subject.deduct(5)).to eq 5
    end

    it "raises an error if balance goes below zero" do
      expect{ subject.deduct(1) }.to raise_error "Not enough funds"
    end
  end

end
