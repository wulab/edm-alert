require 'rails_helper'

describe Event, type: :model do
  context "associations" do
    it { should belong_to(:location) }
    it { should have_many(:users) }
  end

  context "#event" do
    it "creates a new event" do
      event = create(:event)
      expect(event.title).to be_present
    end

    it 'returns a default scope by start_at descending' do
      expect(Event.all.to_sql).to eq Event.all.order('start_at DESC').to_sql
    end

    it 'notify users by email within their area' do
      ActiveJob::Base.queue_adapter = :test
      location = create(:location)
      create(:user, location: location)
      event = build(:event, location: location)

      expect { event.save }.to have_enqueued_job.on_queue('mailers')
    end

    it 'does not notify users by email when the users unsubscribe' do
      ActiveJob::Base.queue_adapter = :test
      location = create(:location)
      create(:user, location: location, unsubscribed_from_emails: true)
      event = build(:event, location: location)

      expect { event.save }.not_to have_enqueued_job.on_queue('mailers')
    end
  end
end
