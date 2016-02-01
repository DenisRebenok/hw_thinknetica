class CargoWagon < Wagon
  attr_reader :max_volume, :free_volume

  def initialize(number, max_volume = 10)
    @number = number
    @free_volume = @max_volume = max_volume
    @type = :cargo
  end

  def take_volume(volume)
    fail 'Not enought space' if max_volume < volume || free_volume < volume
    self.free_volume -= volume
  rescue
    false
  end

  def given_volume
    max_volume - free_volume
  end

  def to_s
    super + " with #{free_volume} free volume and #{given_volume} given volume."
  end

  protected

  attr_writer :free_volume

  alias take_space take_volume
end
