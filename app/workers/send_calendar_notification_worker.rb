class SendCalendarNotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(event_id)
    event = Event.find(event_id)
    calendar = event[:calendar]
    from     = event[:from]

    cal = calendar(Event.dates_for(calendar, from))
    url = upload_to_s3(cal.draw).url

    CalendarEventMailer.send_calendar(event, url).deliver
  end

  def upload_to_s3(blob)
    S3Uploader.new(blob).perform
  end

  def calendar(marked)
    Calendar.new(marked)
  end

end
