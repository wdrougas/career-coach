class Analysis < ApplicationRecord
  belongs_to :resume
  belongs_to :job

  validates :match_score, presence: true
end
