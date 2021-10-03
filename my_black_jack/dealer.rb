# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'

class User
  attr_reader :current_cards, :score
  attr_accessor :name, :money, :deck

  def initialize(name = 'dealer')
    @money = 100
    @current_cards = []
    @score = 0
    @name = name
  end

  def bet!
    @money -= 10
  end

  def distribution_of_cards(deck)
    2.times do
      take_card(deck)
    end
  end

  def take_card(deck)
    @current_cards << deck.cards.delete_at(0)
  end

  def count_score
    @score = 0
    @current_cards.each do |card|
      @score += card.value
      @score -= 10 if card.name == 'Ace' && score > 21
    end
    @score
  end
end
