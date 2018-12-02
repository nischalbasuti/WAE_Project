class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  after_initialize :init

  @ROLES = ['coordinator', 'volunteer', 'representitive', 'participant']
  @PRIVILAGE_LEVEL_HASH = {
    0 => "Manage Forums",
    1 => "Manage Forums, Activities",
    2 => "Manage Forums, Activities, Requirements",
    3 => "Manage Forums, Activites, Requirements, Event",
  }

  def init
    self.privilage_level ||= 0
  end

  class << self
    attr_accessor :ROLES
    attr_accessor :PRIVILAGE_LEVEL_HASH
  end
end
