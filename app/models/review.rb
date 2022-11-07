class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  delegate :name, to: :user, prefix: true

  scope :by_created_at, ->{order(created_at: :desc)}

  validates :comment, presence: true,
            length: {maximum: Settings.review.comment.max_length}
end
