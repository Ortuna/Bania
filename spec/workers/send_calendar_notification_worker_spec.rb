require 'spec_helper'

describe SendCalendarNotificationWorker do
  let(:subject) { SendCalendarNotificationWorker }
  before do
    time      = Time.now
    @all_times = []

    3.times do |i|
      Event.create(from: 'some-user@test.com',
      calendar: 'example',
      created_at: time - i.days)
      @all_times.push(time - i.days)
    end

    @double   = double(Calendar).as_null_object
    @instance = subject.new

    allow(@instance).to receive(:upload_to_s3).with(anything)
  end

  describe '#perform' do
    it 'generates a calendar image' do
      expect(@instance).to receive(:calendar)
        .with(@all_times)
        .and_return(@double)

      @instance.perform(Event.first)
    end

    it 'sends the image data to s3' do
      expect(@instance).to receive(:upload_to_s3).with(anything)
      @instance.perform(Event.first)
    end

  end

end
