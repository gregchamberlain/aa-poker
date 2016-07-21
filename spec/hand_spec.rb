require 'rspec'
require 'hand'


describe Hand do

  let(:hand) { Hand.new }
  let(:card) { double("card", value: 4, suit: :spade) }

  describe "#<<" do
    it "adds the card to the hand" do
      hand << card
      expect(hand.cards).to include(card)
    end
  end

  let(:prc) { proc { |val, suit| double("card", value: val, suit: suit) }}

  let(:high_card) {
    [[4,:heart],[14,:spade],[5,:heart],[11,:spade],[10,:diamond]].map(&prc)
  }

  let(:pair) {
    [[4,:heart],[4,:spade],[5,:heart],[11,:spade],[10,:diamond]].map(&prc)
  }
  let(:same_pair) {
    [[4,:heart],[4,:spade],[5,:heart],[11,:spade],[9,:diamond]].map(&prc)
  }
  let(:two_pair) {
    [[4,:heart],[4,:spade],[5,:heart],[5,:spade],[10,:diamond]].map(&prc)
  }
  let(:three) {
    [[4,:heart],[4,:spade],[4,:diamond],[11,:spade],[10,:diamond]].map(&prc)
  }
  let(:straight) {
    [[2,:heart],[3,:spade],[4,:heart],[5,:spade],[14,:diamond]].map(&prc)
  }
  let(:flush) {
    [[2,:spade],[4,:spade],[5,:spade],[11,:spade],[10,:spade]].map(&prc)
  }
  let(:full_house) {
    [[4,:heart],[4,:spade],[5,:heart],[5,:spade],[5,:diamond]].map(&prc)
  }
  let(:four) {
    [[4,:heart],[4,:spade],[4,:heart],[4,:club],[10,:diamond]].map(&prc)
  }
  let(:straight_flush) {
    [[2,:heart],[3,:heart],[4,:heart],[5,:heart],[6,:heart]].map(&prc)
  }

  describe "#discard" do
    it "discards no cards" do
      hand.cards = pair
      hand.discard([])
      expect(hand.size).to be(5)
    end
    it "discards 3 cards" do
      hand.cards = pair
      hand.discard([1,2,4])
      expect(hand.size).to be(2)
    end
  end

  describe "#score" do



    it "recognizes a high card" do
      hand.cards = high_card
      expect(hand.score).to eq(:high_card)
    end

    it "recognizes a pair" do
      hand.cards = pair
      expect(hand.score).to eq(:pair)
    end

    it "recognizes a two pair" do
      hand.cards = two_pair
      expect(hand.score).to eq(:two_pair)
    end

    it "recognizes a three-of-a-kind" do
      hand.cards = three
      expect(hand.score).to eq(:three)
    end

    it "recognizes a straight" do
      hand.cards = straight
      expect(hand.score).to eq(:straight)
    end

    it "recognizes a flush" do
      hand.cards = flush
      expect(hand.score).to eq(:flush)
    end

    it "recognizes a full house" do
      hand.cards = full_house
      expect(hand.score).to eq(:full_house)
    end

    it "recognizes a four of a kind" do
      hand.cards = four
      expect(hand.score).to eq(:four)
    end

    it "recognizes a straight flush" do
      hand.cards = straight_flush
      expect(hand.score).to eq(:straight_flush)
    end

  end

  describe "#<=>" do
    let(:hand2) { Hand.new }
    let(:high_pair) {
      [[12,:heart],[12,:spade],[5,:heart],[8,:spade],[10,:diamond]].map(&prc)
    }
    let(:two_pair2) {
      [[4,:heart],[4,:spade],[5,:heart],[5,:spade],[11,:diamond]].map(&prc)
    }
    it "full house beats pair" do
      hand.cards = full_house
      hand2.cards = pair
      expect(hand <=> hand2).to be(1)
    end

    it "flush beats straight" do
      hand.cards = flush
      hand2.cards = straight
      expect(hand <=> hand2).to be(1)
    end

    it "higher pair beats lower pair" do
      hand.cards = pair
      hand2.cards = high_pair
      expect(hand <=> hand2).to be(-1)
    end

    it "high card wins on same two pairs" do
      hand.cards = two_pair
      hand2.cards = two_pair2
      expect(hand <=> hand2).to be(-1)
    end

    it "high card wins on same pairs" do
      hand.cards = pair
      hand2.cards = same_pair
      expect(hand <=> hand2).to be(1)
    end

  end

end
