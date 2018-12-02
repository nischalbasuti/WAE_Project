class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable
  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events

  belongs_to :department , optional: true

  acts_as_commontator

  after_initialize :init

  # 'global_role' are roles for administration of the website.
  # on the other hand, 'roles' are for specific events.
  GLOBAL_ROLES = ['admin', 'chair', 'member', 'banned']
  @GLOBAL_ROLES = ['admin', 'chair', 'member', 'banned']
  class << self
    attr_accessor :GLOBAL_ROLES
  end

  def init
    self.global_role ||= GLOBAL_ROLES[2]
  end

  def set_global_role(role)
    if GLOBAL_ROLES.include? role
      self.global_role = role
    else
      return false
    end
    return true
  end

  def forum? forum
    self.forums.include? forum
  end

  # Methods to check global roles.

  def admin?
    self.global_role == GLOBAL_ROLES[0] if !self.global_role.blank?
  end

  def chair?
    self.global_role == GLOBAL_ROLES[1] if !self.global_role.blank?
  end

  def member?
    self.global_role == GLOBAL_ROLES[2] if !self.global_role.blank?
  end

  def banned?
    self.global_role == GLOBAL_ROLES[3] if !self.global_role.blank?
  end

  # Methods to check event roles.

  def coordinator? event
    self.user_events.where(event: event, role: 'coordinator').count >= 1
  end

  def privilage_level event
    # TODO use an if to check if null
    begin
      return self.user_events.where(event: event, role: 'coordinator').first.privilage_level
    rescue
      return -1
    end
  end

  def volunteer? event
    self.user_events.where(event: event, role: 'volunteer').count >= 1
  end

  def representitive? event
    self.user_events.where(event: event, role: 'representitive').count >= 1
  end

  def participant? event
    self.user_events.where(event: event, role: 'participant').count >= 1
  end

  # Setters for self.global_role.

  def make_admin
    self.global_role = GLOBAL_ROLES[0]
  end

  def make_chair
    self.global_role = GLOBAL_ROLES[1]
  end

  def make_member
    self.global_role = GLOBAL_ROLES[2]
  end

  def ban
    self.global_role = GLOBAL_ROLES[3]
  end

  # Setters for event roles.

  def set_event_role(event, role)
    if UserEvent.ROLES.include? role
      if self.user_events.where(event: event, role: role).count == 0
        self.user_events.new(event: event, role: role)
      end
    else
      return false
    end
    return true
  end

  def make_coordinator event
    if self.user_events.where(event: event, role: 'coordinator').count == 0
        self.user_events.new(event: event, role: 'coordinator')
    end
  end

  def make_volunteer event
    if self.user_events.where(event: event, role: 'volunteer').count == 0
        self.user_events.new(event: event, role: 'volunteer')
    end
  end

  def make_representitive event
    if self.user_events.where(event: event, role: 'representitive').count == 0
        self.user_events.new(event: event, role: 'representitive')
    end
  end

  def make_participant event
    if self.user_events.where(event: event, role: 'participant').count == 0
        self.user_events.new(event: event, role: 'participant')
    end
  end
end
