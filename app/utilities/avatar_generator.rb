require 'rubygems'
require 'chunky_png'
require 'yaml'

class AvatarGenerator

ITERATIONS = *(110..190)
RGB = *(0..255)
ALPHA = *(0..255)
X_MAX = 600
Y_MAX = 600
X = *(0..X_MAX-1)
Y = *(0..Y_MAX-1)

  def self.from_seed(seed)
    png = ChunkyPNG::Image.new(X_MAX, Y_MAX, random_color)
    
    pepper_with_color(png)

    config = YAML.load_file('config/sprinkles.yml')
    config[:sprinkles].each do |sprinkle|
      apply_sprinkle(sprinkle,png)
    end

    filename = "#{seed}.png"
    png.save("app/assets/images/#{filename}")
    filename
  end

  def self.pepper_with_color(base_image)
    square_size = 20
    ITERATIONS.sample.times do |i|
      x = rand(base_image.width-square_size)
      y = rand(base_image.height-square_size)
      square = ChunkyPNG::Image.new(square_size,square_size, random_color)
      stamp(square,base_image,x,y)
    end
  end

  def self.stamp(stamp,base_image,
    x=rand(0..(base_image.width-stamp.width)-1),
    y=rand(0..(base_image.height-stamp.height)-1))
    base_image.compose!(stamp,x,y)
  end

  def self.random_color(options = {})
    ChunkyPNG::Color.rgba(RGB.sample,RGB.sample,RGB.sample,128)
  end

  def self.apply_sprinkle(sprinkle, image)
    if rand(100) <= sprinkle[:rate]
      sprinkle_image = ChunkyPNG::Image.from_file(sprinkle[:location])
      rand(sprinkle[:min]..sprinkle[:max]).times do
        stamp(sprinkle_image,image)
      end
    end
  end
end