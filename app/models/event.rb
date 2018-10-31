class Event < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :forums, dependent: :destroy
  has_many :user_events, dependent: :destroy
end
