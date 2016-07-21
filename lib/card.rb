class Card
  attr_reader :suit, :value
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def ==(card)
    card.value == value && card.suit == suit
  end

  def <=>(card)
    value <=> card.value
  end
end
