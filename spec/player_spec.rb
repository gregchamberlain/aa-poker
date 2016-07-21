require 'rspec'
require 'player'

describe Player do
  let(:deck) { double("deck") }
  let(:player) { Player.new("greg", 100, deck) }

  describe "#initialize" do
    it "names the player" do
      expect(player.name).to eq("greg")
    end

    it "gives the player money" do
      expect(player.bank).to be(100)
    end
  end

  describe "#set_hand" do
    it "sets the players hand" do
      expect(deck).to receive(:get_card).exactly(5).times
      player.set_hand
      expect(player.hand.size).to be(5)
    end
  end

  describe "#discard" do
    it "calls Hand#discard" do
      expect(player.hand).to receive(:discard).with([])
      player.discard([])
    end
  end

  describe "#get_card" do
    it "gets a card from the deck" do
      expect(deck).to receive(:get_card)
      player.get_card
    end
  end


end
