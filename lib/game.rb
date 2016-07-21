require_relative 'deck'
require_relative 'player'

class Game

  attr_reader :players, :deck, :active_players

  def initialize(players)
    @players = players
    @active_players = @players.dup
    @deck = Deck.new
    @pot = 0
  end

  def play_round
    @pot = 0
    @deck.shuffle!
    @active_players = @players.dup
    @active_players.each do |player|
      player.clear_hand
      player.set_hand
    end
    bet = betting_round(10)
    discarding_round
    betting_round(bet)
    
  end

  def discarding_round
    @active_players.each do |player|
      player.discard
    end
  end

  def betting_round(current_bet)
    all_check = false
    first_round = true
    until all_check
      all_check = true
      @active_players.each do |player|
        next if all_check && player.bet == current_bet && !first_round
        bet = player.get_bet(current_bet)
        case bet
        when :fold
          @active_players.delete(player)
          next
        else
          @pot += bet[1]
          current_bet = bet[0]
          if bet[1] > 0
            @active_players.rotate!(@active_players.index(player) + 1)
            all_check = false
            break
          end
        end
      end
      first_round = false
    end
    current_bet
  end

  def current_player
    @active_players[0]
  end

  def next_player!
    @active_players.rotate!
  end

end
