class Event < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :forums, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events

  before_save :validate_dates
  before_create :validate_dates

  def valid_dates?
    # Checking (1) if the activites start and end time lie between the duration
    # of it's event and (2) if the start time is less than end time.
    return ( self.start_time <= self.end_time && self.start_time > DateTime.now)
  end
  
  def validate_dates
    if not self.valid_dates?
      throw :abort
    end
  end

end
