class EventsController < ApplicationController
  def create
    event = create_event(params["To"], params["sender"], params["body-plain"])

    #Fire sidekiq queue here
    SendCalendarNotificationWorker.perform_async(event.id)
    render nothing: true
  end

  private
  def create_event(calendar, from, body)
    Event.create(from: params["sender"],
                 body: params["body-plain"],
                 calendar: strip_domain(params["To"]))
  end

  def strip_domain(address)
    matches = address.match("^(.+)@.*$")
    matches[1]
  end
end
