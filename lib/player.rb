require_relative 'hand'

class Player

  attr_reader :name, :bank, :hand, :bet

  def initialize(name,bank,deck)
    @name = name
    @bank = bank
    @hand = Hand.new
    @deck = deck
    @bet = 0
  end

  def add_bet(bet)
    @bet += bet
    @bank -= bet
  end

  def clear_hand
    @hand.clear
  end

  def set_hand
    get_card until hand.size == 5
  end

  def get_card
    @hand << @deck.get_card
  end

  def discard
    puts "What cards would you like to discard?"
    puts @hand
    cards = gets.chomp.split(",").map(&:to_i)
    @hand.discard(cards)
    set_hand
  end

  def get_bet(current_bet)
    puts "How much would you like to bet? (C to call/check, F to fold, raise amount to raise)"
    puts "Current bet: #{current_bet} Your bet: #{@bet}"
    bet = gets.chomp
    case bet.downcase
    when "f"
      return :fold
    when "c"
      raise NoMoneyError if @bank - (current_bet - @bet) < 0
      @bank -= (current_bet - @bet)
      @bet = current_bet
      return [@bet, 0]
    else
      next_bet = current_bet + bet.to_i
      raise NoMoneyError if @bank - (next_bet - @bet) < 0
      raise_bet = next_bet - @bet
      @bank -= raise_bet
      @bet = next_bet
      return [@bet, raise_bet]
    end
  rescue NoMoneyError => e
    puts "You dont have that much money!"
    retry
  end
end

class NoMoneyError < StandardError
end
