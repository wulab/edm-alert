class Product < ApplicationRecord
  # https://github.com/rails/rails/issues/18233#issuecomment-221201414
  belongs_to :post, optional: true

  validates :name, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :x, :y, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 1.0 }, allow_nil: true
end
