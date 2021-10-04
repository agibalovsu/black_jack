# frozen_string_literal: true

class Interface
  def chose_name
    puts 'Игра Black Jack.'
    puts 'Для начала введите своё имя:'
    gets.chomp.capitalize
  end

  def gamers_turn
    line
    puts 'Выберите действие:'
    puts '1. Пропустить. Передать ход диллеру.'
    puts '2. Взять одну карту.'
    puts '3. Открыть карты.'
    line
  end

  def dealers_turn
    puts 'Диллер завершил свой ход.'
  end

  def dealer_extra
    puts 'Диллер взял дополнительную карту.'
  end

  def player_extra
    puts 'Вы взяли дополнительную карту.'
  end

  def show_player(user)
    puts "Результаты #{user.name}:"
  end

  def show_cards_score(hand)
    line
    puts "Текущие очки: #{hand.count_score}"
    hand.current_cards.each { |card| puts "#{card.lear} #{card.name} " }
    line
  end

  def current_money(money)
    puts "Ваши текущие деньги: #{money}"
  end

  def gamer_won
    puts 'Вы победили!'
  end

  def dealer_won
    puts 'Победил Дилер.'
  end

  def draw
    puts 'Ничья!'
  end

  def play_again?
    puts 'Раунд окончен. Продолжить игру?'
    puts '1. Да'
    puts '2. Нет'
  end

  def lose_money
    puts 'Недостаточно денег для продолжения игры.'
    exit
  end

  def line
    puts '==================================='
  end

  def dealers_turned?
    puts 'Передайте в начале ход дилеру.!'
  end

  def chose_action
    gets.chomp.to_i
  end
end
