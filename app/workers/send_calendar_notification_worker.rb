class SendCalendarNotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(event_id)

  end
end
