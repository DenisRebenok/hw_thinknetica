class CargoWagon < Wagon
  attr_reader :max_volume, :free_volume

  def initialize(max_volume = 10, number)
    super
    @free_volume = @max_volume = max_volume
  end

  def take_volume(volume)
    self.free_volume -= volume if free_volume > volume
  end

  def given_volume
    max_volume - free_volume
  end

  def type
    :cargo
  end

  def to_s
    super + "#{free_volume} free volume and #{given_volume} given volume."
  end

  protected
  attr_writer :free_volume
end