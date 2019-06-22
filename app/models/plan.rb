class Plan < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 100 }
end