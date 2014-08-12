class EventsController < ApplicationController

  def create
    Event.create(from: params["sender"], calendar: strip_domain(params["To"]))
    render nothing: true
  end

  private
  def strip_domain(address)
    matches = address.match("^(.+)@.*$")  
    matches[1]
  end
end
