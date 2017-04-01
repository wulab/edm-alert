require 'rails_helper'

describe NotificationMailer do
  it "is sent to the given email" do
    expect(event_warning_email.to).to eq(%w(email@example.com))
  end

  it "specifies the subject" do
    expect(event_warning_email.subject).to eq(
      "Earthquake at sample location - SafetyAlert"
    )
  end

  it "specifies the welcome message" do
    expect(event_warning_email).to(
      have_body_text("Earthquake at sample location")
    )
  end
  
  it 'is sent from SafetyAlert' do
    expect(event_warning_email.from).to include(ENV["SUPPORT_EMAIL"])
  end

  def event_warning_email
    location = build(:location)
    user = build(:user, email: "email@example.com", location: location)
    event = build(
      :event, title: "Earthquake at sample location", location: location
    )

    NotificationMailer.event_warning(user, event)
  end
end
