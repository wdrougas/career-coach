class User < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :resumes, dependent: :destroy

  validates :email, presence: true
end
