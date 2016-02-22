class PassengerWagon < Wagon
  attr_reader :max_places, :free_places

  def initialize(number, max_places = 10)
    @number = number
    @free_places = @max_places = max_places
    @type = :passenger
  end

  def take_place(places)
    fail 'Not enought space' if max_places < places || free_places < places
    self.free_places -= places
  rescue
    false
  end

  def given_places
    max_places - free_places
  end

  def to_s
    super + " with #{free_places} free places and #{given_places} given places."
  end

  protected

  attr_writer :free_places

  alias take_space take_place
end
