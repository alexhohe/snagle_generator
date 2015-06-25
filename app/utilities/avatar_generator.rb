require 'rubygems'
require 'chunky_png'

class AvatarGenerator

ITERATIONS = *(20..50)
RGB = *(0..255)
ALPHA = *(0..255)
X = *(0..15)
Y = *(0..15)

  def self.from_seed(seed)
    png = ChunkyPNG::Image.new(X.max+1, Y.max+1, ChunkyPNG::Color::TRANSPARENT)

    ITERATIONS.sample.times do |i|
      png[X.sample,Y.sample] = random_color
    end

    filename = "#{seed}.png"
    png.save("app/assets/images/#{filename}", :interlace => true)
    filename
  end

  def self.random_color(options = {})
    ChunkyPNG::Color.rgba(RGB.sample,RGB.sample,RGB.sample,128)
  end

end