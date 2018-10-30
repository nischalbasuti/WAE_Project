class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  ROLES = ['coordinator', 'volunteer', 'representitive', 'participant']
end
