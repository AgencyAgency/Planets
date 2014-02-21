class Planet

  def initialize size, orbit, hue, deg_vel, degs, sketch_w, sketch_h
    @size = size
    @degs = degs
    @orbit = orbit
    @hue = hue
    @deg_vel = deg_vel # angular velocity in degs
    @width = sketch_w
    @height = sketch_h
  end

  def display
    @degs += @deg_vel

    push_matrix

    translate @width/2.0, @height/2.0
    fill @hue, 100, 100
    theta = Math::PI * @degs / 180.0
    x = x_from_polar(@orbit, theta)
    y = y_from_polar(@orbit, theta)
    ellipse x, y, @size, @size

    pop_matrix
  end

  def x_from_polar(r, theta)
    return r * Math.cos(theta)
  end

  def y_from_polar(r, theta)
    return r * Math.sin(theta)
  end

end

def setup
  size 1200, 800

  color_mode(HSB, 360, 100, 100)

  @num_planets = 1000
  @planets = []
  # @planets << Planet.new(20, 0,   3,  0, width, height)
  # @planets << Planet.new(40, 120, 30, 90, width, height)
  # @planets << Planet.new(100, 240, 10, 270, width, height)
  @num_planets.times do
    @planets << Planet.new(rand(50), rand(width/2.0), rand(360), rand(100), rand(360), width, height)
  end
end

def draw
  background 0

  # @planets[0].display
  # @planets[1].display
  @planets.each do |planet|
    planet.display
  end

end
