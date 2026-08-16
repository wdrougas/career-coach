class Job < ApplicationRecord
  belongs_to :user

  validates :company, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
