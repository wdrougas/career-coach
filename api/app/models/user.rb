class User < ApplicationRecord
  has_many :resumes
  has_many :jobs
end
