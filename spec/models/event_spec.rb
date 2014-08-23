require 'rails_helper'

describe Event do
  it 'requires the :calendar and :from field' do
    event = Event.new
    event.valid?

    expect(event.errors[:calendar]).not_to be_empty
    expect(event.errors[:from]).not_to be_empty
  end

  describe '#streak_for' do
    it 'gives the current streak for this user and calendar' do
      time = Time.now
      (0..3).map { |i| Event.create(calendar: 'cool', from: 'user@user.com', created_at: time - i.days) }
      Event.create(calendar: 'cool', from: 'user@user.com', created_at: time - 10.days) 

      expect(Event.streak_for(calendar: 'cool', from: 'user@user.com')).to eq(4)
    end
  end

  describe '#dates_for' do
    it 'returns all dates for a particular calendar and user' do
      time = Time.now
      3.times { Event.create(calendar: 'cool', from: 'user@user.com', created_at: time) }
      Event.create(calendar: 'other', from: 'user@user.com', created_at: time)

      expect(Event.dates_for(calendar: 'cool', from: 'user@user.com').count).to eq(3)
      expect(Event.dates_for(calendar: 'cool', from: 'user@user.com').first).to eq(time)
    end
  end

  describe '#for_calendar' do
    it 'returns all events for a user on a calendar' do
      3.times { Event.create(calendar: 'cool', from: 'user@user.com') }
      Event.create(calendar: 'other', from: 'user@user.com')

      expect(Event.for_calendar(calendar: 'cool',  from: 'user@user.com').count).to eq(3)
      expect(Event.for_calendar(calendar: 'other', from: 'user@user.com').count).to eq(1)
    end
  end 

  describe '#for_email' do
    it 'returns all events for a user'  do 
      3.times { Event.create(calendar: 'cool', from: 'user@user.com') }
      Event.create(calendar: 'other', from: 'user@user.com')

      expect(Event.for_email(from: 'user@user.com').count).to eq(4)
    end
  end
end
