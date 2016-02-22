require_relative 'validation'
require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagon.rb'
require_relative 'cargo_wagon.rb'

class Test
  include Validation

  attr_reader :train_number, :train, :nil_var

  validate :nil_var, :presence
  validate :train_number, :format, /^[а-яa-z\d]{3}-?[а-яa-z\d]{2}$/i
  validate :train, :type, PassengerTrain

  def initialize
    begin
      @nil_var ||= nil
      validate!
    rescue => e
      puts e.message
      @nil_var = 1
    end

    begin
      @train_number ||= '666'
      validate!
    rescue => e
      puts e.message
      @train_number = '777-77'
    end

    begin
      @train ||= Train.create('cargo', train_number, 13, 0)
      validate!
    rescue => e
      puts e.message
      @train = Train.create('passenger', train_number, 13, 0)
    end    
  end

  private

  attr_writer :train_number, :train
end

test = Test.new
puts test.valid? ? "Valid" : "Invalid"