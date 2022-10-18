class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  delegate :name, to: :user, prefix: true
end
