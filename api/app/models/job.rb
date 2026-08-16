class Job < ApplicationRecord
  belongs_to :user
  has_many :analyses, dependent: :destroy

  validates :company, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
