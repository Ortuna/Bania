require 'rails_helper'

describe EventsController do
  describe '#create' do
    def post_request
      post :create,
        "sender" => "user@test.com",
        "To" => "example@xyz.com",
        "Subject" => "something"
    end

    it 'can create a new event entry' do
      post_request 
      expect(Event.find_by(from: 'user@test.com')).not_to be_nil
    end

    it 'strips the domain from the To field' do
      post_request 
      expect(Event.find_by(from: 'user@test.com')[:calendar]).to eq('example')
    end

    it 'sets the body to the correct field' do
      post_request 
      expect(Event.find_by(from: 'user@test.com')[:body]).to eq('something')
    end

    it 'queues up the SendCalendarNotificationWorker' do
      post_request 
      expect(SendCalendarNotificationWorker).to have(1).job
    end
  end

  describe '#strip_domain' do
    it 'gets the calendar name from the email address' do
      calendar = controller.send(:strip_domain, "test@example.com") 
      expect(calendar).to eq("test")
    end
  end

end
