class Event < ActiveRecord::Base
  validates :from, presence: true
  validates :calendar, presence: true

  def self.dates_for(calendar, from)
    for_calendar(calendar, from)
      .pluck(:created_at)
  end

  def self.for_calendar(calendar, from)
    for_email(from)
      .where(calendar: calendar)
  end

  def self.for_email(from)
    where(from: from)
  end

end
