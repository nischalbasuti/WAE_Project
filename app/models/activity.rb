class Activity < ApplicationRecord
  belongs_to :event
  has_many :requirements, dependent: :destroy
end
