class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable
  has_many :user_roles
  has_many :roles, through: :user_roles

  # 'global_role' are roles for administration of the website.
  # on the other hand, 'roles' are for specific events.
  GLOBAL_ROLES = ['admin', 'member', 'banned']

  def admin?
    self.global_role.name == "admin" if  !self.role.blank?
  end

  def member?
    self.global_role == "member" if !self.role.blank?
  end

  def banned?
    self.global_role == "banned" if !self.role.blank?
  end
end
