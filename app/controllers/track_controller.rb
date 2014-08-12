class TrackController < ApplicationController

  def create
    cal = ::Calendar.new(Event.dates_for('test', 'ortuna@gmail.com'))
    render text: cal.draw(), content_type: 'image/png'
  end
end
