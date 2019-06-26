class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  counter_culture :plan
  validates :user_id, presence: true
  validates :plan_id, presence: true
end
