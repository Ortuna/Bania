class EventsController < ApplicationController
  def create
    calendar = strip_domain(params["recipient"])
    from     = params["sender"]
    subject  = params["Subject"]

    render_fail and return unless calendar

    event = create_event(calendar, from, subject)
    SendCalendarNotificationWorker.perform_async(event.id)

    render nothing: true
  end

  private
  def render_fail
    render nothing: true, status: 422
  end

  def create_event(calendar, from, body)
    Event.create(calendar: calendar, from: from, body: body)
  end

  def strip_domain(address)
    address.match("^(.+)@.*$")[1]
  rescue
    nil
  end
end
