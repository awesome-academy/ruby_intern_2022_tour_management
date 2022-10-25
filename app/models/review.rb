class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  delegate :name, to: :user, prefix: true

  validates :comment, presence: true,
            length: {maximum: Settings.review.comment.max_length}
end
