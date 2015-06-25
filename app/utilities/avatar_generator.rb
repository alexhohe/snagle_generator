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
    png[1,1] = ChunkyPNG::Color.rgba(10, 20, 30, 128)
    png[2,1] = ChunkyPNG::Color('black @ 0.5')

    ITERATIONS.sample.times do |i|
      png[X.sample,Y.sample] = ChunkyPNG::Color.rgba(RGB.sample,RGB.sample,RGB.sample,ALPHA.sample)
    end

    filename = "#{seed}.png"
    png.save("app/assets/images/#{filename}", :interlace => true)
    filename
  end

end