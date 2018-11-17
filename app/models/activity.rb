class Activity < ApplicationRecord
  belongs_to :event
  has_many :requirements, dependent: :destroy

  before_save :validate_dates

  def valid_dates?
    # Checking (1) if the activites start and end time lie between the duration
    # of it's event and (2) if the start time is less than end time.
    return ( self.start_time.between? self.event.start_time, self.event.end_time and 
     self.end_time.between? self.event.start_time, self.event.end_time and
     self.start_time <= self.end_time )
  end
  
  def validate_dates
    if not self.valid_dates?
      throw :abort
    end
  end

end
