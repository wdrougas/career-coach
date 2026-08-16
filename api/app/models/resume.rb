class Resume < ApplicationRecord
  belongs_to :user
  has_many :analyses, dependent: :destroy

  validates :title, presence: true
end
