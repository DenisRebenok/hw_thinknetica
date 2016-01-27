class PassengerWagon < Wagon
  attr_reader :max_places, :free_places

  def initialize(max_places = 10, number)
    super
    @free_places = @max_places = max_places
  end

  def take_place(places)
    self.free_places -= places if free_places > places
  end

  def given_places
    max_places - free_places
  end

  def type
    :passenger
  end

  def to_s
    super + "#{free_places} free places and #{given_places} given places."
  end

  protected
  attr_writer :free_places
end