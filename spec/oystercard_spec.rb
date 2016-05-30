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

  end

end
