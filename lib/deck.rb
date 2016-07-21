require_relative 'card'

class Deck

  attr_reader :cards

  def initialize
    @cards = []
    suits = [:spade,:heart,:club,:diamond]
    (2..14).to_a.each do |value|
      suits.each do |suit|
        @cards << Card.new(suit, value)
      end
    end
  end

  def shuffle!
    @cards = []
    suits = [:spade,:heart,:club,:diamond]
    (2..14).to_a.each do |value|
      suits.each do |suit|
        @cards << Card.new(suit, value)
      end
    end
    @cards.shuffle!
  end

  def get_card
    @cards.pop
  end

end
