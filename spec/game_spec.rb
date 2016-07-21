require 'rspec'
require 'game'
require 'deck'

describe Game do
  let(:player1) { double("player", name: "greg", bank: 100) }
  let(:player2) { double("player", name: "denver", bank: 100) }
  let(:game) { Game.new([player1, player2]) }
  describe "#initialize" do
    it "creates a deck" do
      expect(game.deck).to be_a(Deck)
    end

    it "sets players" do
      expect(game.players).to eq([player1, player2])
    end

  end

  describe "#play_round" do
    it "shuffles the deck" do
      expect(game.deck).to receive(:shuffle!)
      game.play_round
    end
    it "resets the active players" do
      game.play_round
      expect(game.active_players).to eq(game.players)
      expect(game.active_players).to_not be(game.players)
    end
  end

  describe "#current_player" do
    it "returns the current player" do
      expect(game.current_player).to eq(player1)
    end
  end

  describe "#next_player!" do
    it "changes the current player" do
      game.next_player!
      expect(game.current_player).to eq(player2)
    end
  end


end
