class Calendar
  include Magick

  attr_accessor :x_offset, :y_offset,
                :size, :margin,
                :marked


  def initialize(marked)
   @x_offset = 0 
   @y_offset = 25 
   @size     = 10
   @margin   = 3 

   @marked   = marked.map(&:beginning_of_day)
  end

  def draw
    image = Image.new(860, 150) { self.background_color = 'white'}

    day   = 363
    month = nil

    x_range.each do |x|
      y_range.each do |y|
        today      = Date.today - day.days
        day   = day - 1
        x_coords = x_offset + x
        y_coords = y_offset + y

        if(month != today.strftime("%b"))
          month = today.strftime("%b")
          draw_month(month, x_coords, image)
          @x_offset = x_offset + size + margin
        end

        draw = Draw.new
        draw.fill = marked_color(today)
        draw.rectangle(x_coords, y_coords, x_coords + size, y_coords + size)
        draw.draw(image)
      end
    end 

    image.to_blob { self.format = 'jpg' }
  end

  private
  def marked_color(date)
    block_color(marked_dates_for(date).count)
  end

  def marked_dates_for(date)
    marked.select {|day| day == date }
  end

  def draw_month(month, x, canvas)
    text = Draw.new
    text.font_family = 'helvetica'
    text.pointsize = 12
    text.gravity   = SouthGravity 
    text.annotate(canvas, 85, 0, x, y_offset, month)
  end

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

  def block_color(count)
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
