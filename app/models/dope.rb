class Dope < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user

  validates :post_id, uniqueness: { scope: :user_id }
end
