class Tag < ApplicationRecord
  validates :name, presence: true
  scope :order_by_name, -> { order('name asc') }
  has_many :post_tags, dependent: :delete_all
end
