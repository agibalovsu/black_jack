# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagons'
require_relative 'interface'
require_relative 'passanger_wagons'
require_relative 'cargo_wagons'

interface = TextInterface.new
interface.run
