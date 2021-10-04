# frozen_string_literal: true

require_relative 'card'

class Deck
  LEARS = %w[♠ ♥ ♦ ♣].freeze
  NAMES_VALUES = {
    '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
    '8' => 8, '9' => 9, '10' => 10, 'Jack' => 10, 'Queen' => 10,
    'King' => 10, 'Ace' => 11
  }.freeze

  attr_accessor :cards

  def initialize
    @cards = []
    create_deck
  end

  def shuffle!
    cards.shuffle!
  end

  private

  def create_deck
    LEARS.each do |lear|
      NAMES_VALUES.each do |name, value|
        @cards << Card.new(name, lear, value)
      end
    end
  end
end
