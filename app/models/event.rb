class Event < ApplicationRecord
  enum category: [ :earthquake, :flood, :rainfall ]
  belongs_to :location
  has_many :users, through: :location
  after_create :notify_users
  paginates_per 20
  scope :this_weeks, -> { where('created_at >= ?', 1.week.ago) }
  scope :most_recent, -> (limit) { order('created_at desc').limit(limit) }

  private
    def notify_users
      users.each do |user|
        NotificationMailer.event_warning(user, self).deliver_later
      end
    end
end
