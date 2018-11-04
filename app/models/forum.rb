class Forum < ApplicationRecord
  acts_as_commontable dependent: :destroy
  belongs_to :event
end
