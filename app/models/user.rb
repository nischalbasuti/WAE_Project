class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable
  has_many :user_roles
  has_many :roles, through: :user_roles

  after_initialize :init

  # 'global_role' are roles for administration of the website.
  # on the other hand, 'roles' are for specific events.
  GLOBAL_ROLES = ['admin', 'coordinator', 'member', 'banned']

  # - Admin is the website admin.
  # - Coordinator can create and organize events. They are created by admin or 
  # other coordinators.
  # - Members are other users which are further segregated in 'roles' sepecific
  # to each event.


  def init
    self.global_role ||= GLOBAL_ROLES[2]
  end


  def admin?
    self.global_role.name == "admin" if !self.role.blank?
  end

  def member?
    self.global_role == "member" if !self.role.blank?
  end

  def coordinator?
    self.global_role == "coordinator" if !self.role.blank?
  end

  def banned?
    self.global_role == "banned" if !self.role.blank?
  end
end
