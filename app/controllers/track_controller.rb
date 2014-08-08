class TrackController < ApplicationController

  def create
    cal = ::Calendar.new()
    render text: cal.draw(), content_type: 'image/png'
  end
end
