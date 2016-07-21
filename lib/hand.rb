class Hand

  HAND_SCORES = [
    :high_card,
    :pair,
    :two_pair,
    :three,
    :straight,
    :flush,
    :full_house,
    :four,
    :straight_flush
  ]

  attr_accessor :cards

  def initialize
    @cards = []
  end

  def clear
    @cards = []
  end

  def to_s
    str = ""
    @cards.each { |card| str << "[#{card.value} #{card.suit.to_s}]" }
    str
  end

  def size
    @cards.size
  end

  def discard(cards_idx)
    cards_idx.sort.reverse.each do |idx|
      @cards.delete_at(idx)
    end
  end

  def score
    return :straight_flush if straight_flush
    return :four if four
    return :full_house if full_house
    return :flush if flush
    return :straight if straight
    return :three if three
    return :two_pair if two_pair
    return :pair if pair
    :high_card
  end

  def <=>(hand)
    scores = HAND_SCORES.index(score) <=> HAND_SCORES.index(hand.score)
    return scores unless scores == 0
    case score
    when :straight_flush || :straight || :flush
      cards.last <=> hand.cards.last
    when :four
      first_hand = value_of_matching_cards(4)[0]
      second_hand = hand.value_of_matching_cards(4)[0]
      first_hand <=> second_hand
    when :full_house || :three
      first_hand = value_of_matching_cards(3)[0]
      second_hand = hand.value_of_matching_cards(3)[0]
      first_hand <=> second_hand
    when :two_pair
      first_hand = value_of_matching_cards(2)[1]
      second_hand = hand.value_of_matching_cards(2)[1]
      compare = first_hand <=> second_hand
      return compare unless compare == 0
      first_hand = value_of_matching_cards(2)[0]
      second_hand = hand.value_of_matching_cards(2)[0]
      compare = first_hand <=> second_hand
      return compare unless compare == 0
      first_hand = value_of_matching_cards(1)[0]
      second_hand = hand.value_of_matching_cards(1)[0]
      compare = first_hand <=> second_hand
    when :pair
      first_hand = value_of_matching_cards(2)[0]
      second_hand = hand.value_of_matching_cards(2)[0]
      compare = first_hand <=> second_hand
      return compare unless compare == 0
      first_hand = value_of_matching_cards(1).sort
      second_hand = hand.value_of_matching_cards(1).sort
      until first_hand.last != second_hand.last || first_hand.empty?
        first_hand.pop
        second_hand.pop
      end
      first_hand.last <=> second_hand.last
    when :high_card
      first_hand = cards.sort
      second_hand = hand.cards.sort
      until first_hand.last != second_hand.last || first_hand.empty?
        first_hand.pop
        second_hand.pop
      end
      first_hand.last <=> second_hand.last
    end
  end

  def value_of_matching_cards(count)
    same_count.reject { |_, v| v != count }.keys
  end

  def <<(card)
    @cards << card
  end


  private

  def straight_flush
    straight && flush
  end

  def straight
    sort_hand!

    (0..3).each do |index|
      break if index == 3 && cards.last.value == 14 && cards[-2].value == 5
      return false unless cards[index].value + 1 == cards[index + 1].value
    end
    true
  end

  def flush
    return false unless cards.all? do |card|
      card.suit == cards[0].suit
    end
    true
  end

  def sort_hand!
    @cards.sort! { |a, b| a.value <=> b.value}
  end

  def full_house
    three && pair
  end

  def four
    same_count.values.include?(4)
  end

  def two_pair
    same_count.values.count(2) == 2
  end

  def three
    same_count.values.include?(3)
  end

  def pair
    same_count.values.include?(2)
  end

  protected

  def same_count
    count = Hash.new(0)
    @cards.each { |card| count[card.value] += 1 }
    count
  end


end
