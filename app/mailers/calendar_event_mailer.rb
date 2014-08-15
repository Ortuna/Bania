class CalendarEventMailer < ActionMailer::Base
  default from: "hello@bania.io"

  def send_calendar(event, calendar_image_url)
    @image_url = calendar_image_url

    mail(from: "#{event[:calendar]}@bania.io",
         to: event[:from],
         subject: 'Bania Calendar')
  end

  private
end
