class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable
  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events

  after_initialize :init

  # 'global_role' are roles for administration of the website.
  # on the other hand, 'roles' are for specific events.
  GLOBAL_ROLES = ['admin', 'chair', 'member', 'banned']
  @GLOBAL_ROLES = ['admin', 'chair', 'member', 'banned']
  class << self
    attr_accessor :GLOBAL_ROLES
  end


  # - Admin is the website admin.
  # - Coordinator can create and organize events. They are created by admin or 
  # other coordinators.
  # - Members are other users which are further segregated in 'roles' sepecific
  # to each event.


  def init
    self.global_role ||= GLOBAL_ROLES[2]
  end


  # Check self.global_role
  #
  def set_global_role(role)
    if GLOBAL_ROLES.include? role
      self.global_role = role
    else
      return false
    end
    return true
  end
  
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


end
