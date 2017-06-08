class Subject < ApplicationRecord
  has_many :notifications

  validates :type,  presence: true
  validates :title, presence: true
  validates :url,   presence: true
end
