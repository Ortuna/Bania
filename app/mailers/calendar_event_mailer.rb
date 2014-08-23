class CalendarEventMailer < ActionMailer::Base
  default from: "hello@bania.io"

  def send_calendar(event, calendar_image_url)
    @image_url   = calendar_image_url
    @total_count = Event.for_calendar(calendar: event[:calendar], from: event[:from]).count
    @streak      = Event.streak_for(calendar: event[:calendar], from: event[:from])

    mail(from: "#{event[:calendar]}@bania.io",
         to: event[:from],
         subject: 'Bania Calendar')
  end

  private
end
