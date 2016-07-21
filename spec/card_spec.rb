require 'rspec'
require 'card'

describe Card do
  let(:card) { Card.new(:spade,10) }
  it "initializes correctly" do
    expect(card.suit).to eq(:spade)
    expect(card.value).to eq(10)
  end
end
