class Event < ApplicationRecord
  enum category: [ :earthquake, :flood ]
  belongs_to :location
  has_many :users, through: :location
  after_create :notify_users

  private
    def notify_users
      users.each do |user|
        NotificationMailer.event_warning(user, self).deliver_later
      end
    end
end
