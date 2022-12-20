class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :comment, :user_name
  belongs_to :user
  belongs_to :tour
end
