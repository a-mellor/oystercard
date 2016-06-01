require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  let(:min_bal) { Oystercard::MINIMUM_BALANCE }
  let(:min_fare) { Oystercard::MINIMUM_FARE }

  let(:station1) {double (:liverpool_street)}
  let(:station2) {double (:bank)}

  describe '#top_up' do

    let(:max_bal) { Oystercard::MAXIMUM_BALANCE }

    it 'checks new oystercard has zero balance' do
      expect(oystercard.balance).to eq(0)
    end

    it 'adds money to oystercard' do
      expect{ oystercard.top_up(1) }.to change{ oystercard.balance }.by(1)
    end

    it 'does not allow balance to exceed maximum' do
      message = "Balance can't exceed #{max_bal}"
      expect{oystercard.top_up(max_bal + 1)}.to raise_error(message)
    end

  end

  describe '#touch_in' do
    context 'when no money on card' do

      it 'will not allow touch in if funds are below minimum' do
        message = "Not enough funds"
        expect{oystercard.touch_in(station1)}.to raise_error(message)
      end
    end

    context 'when topped up' do
      before do
        oystercard.top_up(min_bal)
      end

      it 'checks oystercard is initialized out of journey' do
        expect(oystercard.in_journey?).to eq(false)
      end

      it 'touching in changes status of oystercard to in journey' do

        oystercard.touch_in(station1)
        expect(oystercard.in_journey?).to eq(true)
      end

      it 'checks oystercard is not in a journey before touching in' do        message = "Already in a journey"
        oystercard.touch_in(station1)
        expect{oystercard.touch_in(station1)}.to raise_error(message)
      end

      it 'remembers the entry station' do
        expect{oystercard.touch_in(station1)}.to change{oystercard.entry_station}.to (station1)
      end
    end
  end

  describe '#touch_out' do

    it 'checks oystercard is in a journey before touching out' do
      message = "Not yet started journey"
      expect{oystercard.touch_out(station2)}.to raise_error(message)
    end

    it 'touching out changes status of oystercard to not in journey' do
      oystercard.top_up(min_bal)
      oystercard.touch_in(station1)
      oystercard.touch_out(station2)
      expect(oystercard.in_journey?).to eq(false)
    end

    it 'reduces the balance by a minimum fare' do
      oystercard.top_up(10)
      oystercard.touch_in(station1)
      expect{oystercard.touch_out(station2)}.to change{oystercard.balance}.by(-min_fare)
    end

    it 'makes the card forget the entry station upon touching out' do
      oystercard.top_up(min_bal)
      oystercard.touch_in(station1)
      expect{oystercard.touch_out(station2)}.to change{oystercard.entry_station}.to nil
    end
  end

end
