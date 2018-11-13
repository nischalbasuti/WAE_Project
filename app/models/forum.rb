class Forum < ApplicationRecord
  acts_as_commontable dependent: :destroy
  belongs_to :event

  has_many :forum_commenters, dependent: :destroy 

end
