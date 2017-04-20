class Event < ApplicationRecord
  enum category: [ :earthquake, :flood, :rainfall ]
  belongs_to :location
  has_many :users, through: :location
  after_create :notify_users
  paginates_per 20

  default_scope               -> { order('start_at DESC') }
  scope :this_weeks,          -> { where('start_at >= ?', 1.week.ago) }
  scope :most_recent,         -> (limit) { limit(limit) }
  scope :available_locations, -> { joins(:location).pluck(:province).uniq }
  scope :by_category,         -> (category) { where(category: category) }
  scope :by_location,         -> (location) do
    joins(:location).where(locations: { province: location })
  end
  scope :by_postalcode,       -> (postal_code) do
    joins(:location).where(locations: { postal_code: postal_code })
  end
  scope :by_district,         -> (district) do
    joins(:location).where(locations: { district: district })
  end

  private

  def notify_users
    users.reject(&:unsubscribed_from_emails).each do |user|
      NotificationMailer.event_warning(user, self).deliver_later
    end
  end
end
