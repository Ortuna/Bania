require 'spec_helper'

describe Calendar do
  it 'can take in all a users events' do
    3.times { Event.create(calendar: 'something', from: 'user@user.com') }

    dates = Event.dates_for('something', 'user@user.com')
    calendar = Calendar.new(dates)

    expect(calendar.marked).to eq(dates)
  end
end

