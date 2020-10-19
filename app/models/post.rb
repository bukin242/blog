class Post < ApplicationRecord
  validates :name, presence: true
  validates :text, presence: true

  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags

  scope :active, -> { where(active: true) }
end
