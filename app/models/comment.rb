class Comment < ApplicationRecord
  validates :text, presence: true
  belongs_to :post
  belongs_to :user

  EXPIRES_TIME = 15.minutes

  def expires?
    DateTime.current > created_at + EXPIRES_TIME
  end
end
