class Event < ActiveRecord::Base
  validates :from, presence: true
  validates :calendar, presence: true

  def self.for_calendar(calendar, from) 
    for_email(from)
      .where(calendar: calendar)
  end

  def self.for_email(from)
    where(from: from)
  end
end
