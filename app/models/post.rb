class Post < ApplicationRecord
  validates :name, presence: true
  validates :text, presence: true

  belongs_to :user

  scope :active, -> { where(active: true) }
end
