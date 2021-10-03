# frozen_string_literal: true

require_relative 'interface'
require_relative 'dealer'
require_relative 'user'
require_relative 'deck'

class Game
  attr_reader :gamer, :dealer, :deck, :interface

  ACTIONS_MENU = {
    1 => :dealers_turn,
    2 => :extra_card,
    3 => :reavel_cards
  }.freeze

  def initialize
    @interface = Interface.new
    @gamer = Gamer.new(interface.chose_name)
    @dealer = User.new
    start_game
  end

  def start_game
    return @interface.lose_money unless money?

    @deck = Deck.new
    @dealers_turned = false
    round
    @interface.show_cards_score(@gamer)
    gamers_turn
  end

  def money?
    (@gamer.money > 10) && (@dealer.money > 10)
  end

  def round
    @deck.cards.shuffle!
    @gamer.bet!
    @dealer.bet!
    @gamer.current_cards.clear
    @dealer.current_cards.clear
    @gamer.distribution_of_cards(deck)
    @dealer.distribution_of_cards(deck)
  end

  def gamers_turn
    @interface.gamers_turn
    choice = @interface.chose_action
    send ACTIONS_MENU[choice] if ACTIONS_MENU[choice]
    reavel_cards
  end

  def can_extra?
    @gamer.current_cards.length < 3
  end

  def dealer_can_extra?
    @dealer.current_cards.length < 3
  end

  def extra_card
    @gamer.take_card(@deck) if can_extra?
    @interface.player_extra
    dealers_turn
  end

  def dealer_extra
    @dealer.take_card(@deck)
    @interface.dealer_extra
    reavel_cards
  end

  def dealers_turn
    @dealers_turned = true
    @interface.dealers_turn
    sleep(1)
    return reavel_cards if @dealer.count_score >= 17

    dealer_extra if dealer_can_extra? && @gamer.count_score <= 21
  end

  def reavel_cards
    @interface.dealers_turned? unless @dealers_turned
    return gamers_turn unless @dealers_turned

    @interface.show_player(@gamer)
    @interface.show_cards_score(@gamer)
    @interface.show_player(@dealer)
    @interface.show_cards_score(@dealer)
    calc_results
    play_again?
  end

  def calc_results
    case winner
    when @gamer then @gamer.money += 20
                     @interface.gamer_won
    when @dealer then @dealer.money += 20
                      @interface.dealer_won
    when 'draw' then @gamer.money += 10
                     @dealer.money += 10 && @interface.draw
    end
    @interface.current_money(@gamer.money)
  end

  def winner
    if @gamer.score > 21 || @gamer.score < @dealer.score
      @dealer
    elsif @dealer.score > 21 || @gamer.score > @dealer.score
      @gamer
    elsif @dealer.score == @gamer.score
      'draw'
    end
  end

  def play_again?
    @interface.play_again?
    choice = @interface.chose_action
    start_game if choice == 1
    exit if choice == 2
    play_again?
  end
end
