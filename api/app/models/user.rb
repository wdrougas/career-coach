class User < ApplicationRecord
  has_many :resumes
  has_many :jobs

  validates :email, presence: true
end
