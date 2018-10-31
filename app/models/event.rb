class Event < ApplicationRecord
  has_many :activities
  has_many :forums
end
