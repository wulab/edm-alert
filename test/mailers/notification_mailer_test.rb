require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "event_warning" do
    mail = NotificationMailer.event_warning
    assert_equal "Event warning", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
