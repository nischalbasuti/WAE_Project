class Forum < ApplicationRecord
  acts_as_commontable dependent: :destroy
  belongs_to :event

  has_many :forum_commenters, dependent: :destroy 

  def foo
      if self.forum_commenters.count == 0
        return true
      else
        return false
      end
  end

  # Check if a user can use this forum.
  def user? user
    if self.forum_commenters.count == 0
      # If no roles are specified in forum_commenters, all users can use the
      # forum.
      return true
    end
    self.event.user_events.where(user:user).pluck(:role).each do |role|
      if self.forum_commenters.pluck(:role).include? role
        return true
      end
    end
    return false
  end

end
