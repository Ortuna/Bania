class Event < ActiveRecord::Base
  validates :from, presence: true
  validates :calendar, presence: true

  class << self
    def dates_for(calendar:, from:)
      for_calendar(calendar: calendar, from: from)
        .pluck(:created_at)
    end

    def for_calendar(calendar:, from:)
      for_email(from: from)
        .where(calendar: calendar)
    end

    def for_email(from:)
      where(from: from)
    end

    def streak_for(calendar:, from:)
      0.tap do |streak|
        marked_dates = dates_for(calendar: calendar, from: from)
        marked_dates = marked_dates.map(&:yday)

        ((Date.today - 1.year)..Date.today).to_a.map(&:yday).reverse.each do |yday|
          streak += 1 and next if marked_dates.include?(yday)
          return streak
        end
      end
    end

  end

end
