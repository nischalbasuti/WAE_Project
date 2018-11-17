class Activity < ApplicationRecord
  belongs_to :event
  has_many :requirements, dependent: :destroy

  validates_datetime :end_time, :after => :start_time
  validates_date :start_time, :on => :edit,  :on_or_after => lambda { Date.current } 
end
