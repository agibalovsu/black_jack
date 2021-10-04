# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'

class Hand
  attr_reader :current_cards, :score
  attr_accessor :deck

  def initialize
    @current_cards = []
    @score = 0
  end

  def take_card(deck)
    @current_cards << deck.cards.shift
  end

  def count_score
    @score = 0
    @current_cards.each do |card|
      @score += card.value
      @score -= 10 if card.name == 'Ace' && score > 21
    end
    @score
  end

  def distribution_of_cards(deck)
    2.times do
      take_card(deck)
    end
  end
end
