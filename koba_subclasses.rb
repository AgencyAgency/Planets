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

  def move
    @degs += @deg_vel
    theta = Math::PI * @degs / 180.0
    @x = x_from_polar(@orbit, theta)
    @y = y_from_polar(@orbit, theta)
  end

  def display
    push_matrix

    fill @hue, 360, 360, 180
    translate @width/2.0, @height/2.0
    ellipse @x, @y, @size, @size

    pop_matrix
  end

  def x_from_polar(r, theta)
    return r * Math.cos(theta)
  end

  def y_from_polar(r, theta)
    return r * Math.sin(theta)
  end

end

class RingedPlanet < Planet

  def display_ring
    push_matrix

    no_fill
    stroke 255
    ring_size = @size + 50
    translate @width/2.0, @height/2.0
    ellipse @x, @y, ring_size, ring_size

    pop_matrix
  end

  def display
    super.display
    display_ring
  end

end

class CrazyRingedPlanet < RingedPlanet

  def display_ring
    push_matrix

    no_fill
    stroke 255
    translate @width/2.0, @height/2.0

    10.times do
      ring_size = @size + rand(100)
      ellipse @x, @y, ring_size, ring_size
    end

    pop_matrix
  end

end


def setup
  size 1200, 800

  color_mode(HSB, 360)

  @num_planets = 4
  @planets = []

  #Create Ringed Planets:
  @num_planets.times do
    planet_size = rand(300.0)
    orbit_distance = rand(width/4.0)
    hue = 0
    ang_velocity_degrees = rand(4.0) - 2
    starting_degrees = rand(360.0)
    @planets << RingedPlanet.new(planet_size, orbit_distance, hue, ang_velocity_degrees, starting_degrees, width, height)
  end

  #Create Normal Planets:
  @num_planets.times do
    planet_size = rand(300.0)
    orbit_distance = rand(width/4.0)
    hue = 120
    ang_velocity_degrees = rand(4.0) - 2
    starting_degrees = rand(360.0)
    @planets << Planet.new(planet_size, orbit_distance, hue, ang_velocity_degrees, starting_degrees, width, height)
  end

   #Create Normal Planets:
  @num_planets.times do
    planet_size = rand(300.0)
    orbit_distance = rand(width/4.0)
    hue = 240
    ang_velocity_degrees = rand(4.0) - 2
    starting_degrees = rand(360.0)
    @planets << CrazyRingedPlanet.new(planet_size, orbit_distance, hue, ang_velocity_degrees, starting_degrees, width, height)
  end
end

def draw
  background 0

  @planets.each do |planet|
    planet.move
    planet.display
  end

end
