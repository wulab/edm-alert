class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  belongs_to :location

  validates :uid, uniqueness: { scope: :provider }

  # Find or create resource with auth hash returned from omniauth provider.
  def self.find_or_create_with_omniauth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.email = auth.dig("info", "email")
      user.password = Devise.friendly_token
    end
  end

  # Override Devise's method used to build resource in registrations controller.
  def self.new_with_session(params, session)
    super.tap do |user|
      auth = session["devise.omniauth-facebook"]
      if auth.present?
        user.password = Devise.friendly_token
        user.provider = auth["provider"]
        user.uid = auth["uid"]
      end
    end
  end

  # Check if user signed-up through OmniAuth.
  def omniauth?
    provider? && uid?
  end

  def location=(postal_code)
    location = Location.find_by(postal_code: postal_code)
    super(location)
  end
end
