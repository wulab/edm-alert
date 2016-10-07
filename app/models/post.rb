class Post < ApplicationRecord
  attachment :image, type: :image

  belongs_to :author, class_name: "User"
  has_many :dopes, dependent: :destroy
  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :products

  validates :title, presence: true

  scope :latest, -> { order(created_at: :desc) }
  scope :popular, -> { order(dopes_count: :desc, created_at: :desc) }

  def to_builder
    Jbuilder.new do |json|
      json.array! self.products, :position, :x, :y
    end
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
