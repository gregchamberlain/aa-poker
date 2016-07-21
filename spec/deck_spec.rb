require 'rspec'
require 'deck'

describe Deck do
  let(:cards) {
    cards = []
    suits = [:spade,:heart,:club,:diamond]
    (1..13).to_a.each do |value|
      suits.each do |suit|
        cards << double("card", value: value, suit: suit)
      end
    end
    cards
  }
  let(:deck) { Deck.new }
  it "contains all cards" do
    expect(deck.cards).to eq(cards)
  end

  it "shuffles cards" do
    deck.shuffle!
    expect(deck.cards).to_not eq(cards)
  end
end
