class Tag < ApplicationRecord
  validates :name, presence: true
  scope :order_by_name, -> { order('name asc') }
end
