class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  ROLES = ['volunteer', 'representitive', 'participant']
end
