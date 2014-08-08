require 'RMagick'
class Calendar
  include Magick

  attr_accessor :x_offset, :y_offset,
                :size, :margin,
                :marked

  def initialize(options = {})
   @x_offset = 0 
   @y_offset = 25 
   @size     = 10
   @margin   = 3 

   @marked   = [Date.today-10.days, Date.today]
  end

  def draw
    png = Image.new(1000, 500) { self.background_color = 'white'}
    gc  = Draw.new

    day = 363
    month = nil

    x_range.each do |x|
      y_range.each do |y|
        today      = Date.today - day.days
        if(month != today.month)
          month = today.month 
          color = png_color(4)
          @x_offset = @x_offset + 5
        else
          color = marked.include?(today) ? png_color(1) : png_color(0)
        end

        day   = day - 1

        x_coords = x_offset + x
        y_coords = y_offset + y

        gc.stroke = 'black'
        gc.fill    = 'blue'

        gc.rectangle(x_coords, y_coords, x_coords + size, y_coords + size)
      end
    end 

    gc.draw(png)
    png.to_blob { self.format = 'jpg' }
  end

  def drawz
    png = ChunkyPNG::Image.new(1000, 500, ChunkyPNG::Color::TRANSPARENT)

    return png
  end

  private
  def x_range
    range_with_step(52)
  end

  def y_range
    range_with_step(7)
  end

  def range_with_step(num)
    range_end = (size + margin) * num
    (1..range_end).step(size + margin)
  end

  def png_color(count)
    ChunkyPNG::Color.from_hex(range_color_in_hex(count))
  end

  def range_color_in_hex(count)
    case count
    when 0
      return '#EEEEEE'  
    when 1
      return '#D6E685'  
    when 2
      return '#8CC665'  
    when 3 
      return '#44A340'  
    when 4 
      return '#1E6823'  
    else
      return '#EEEEEE'
    end
  end
end
