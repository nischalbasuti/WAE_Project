class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.chair?
      can :manage, Event
      can :manage, Requirement
      can :manage, User do |u|
        u == user
      end
      can :manage, Forum # TODO: change this shit.
      # can :read, :all
    elsif user.member?
      can :manage, User do |u|
        u == user
      end

      # Coordinator special privilages

      can :create, Forum  # TODO: In controller, make sure only user.privilage_level(f.event) >= 0 can create
      can :manage, Forum do |f|
        user.coordinator? f.event and user.privilage_level(f.event) >= 0
      end
      can :manage, Activity do |a|
        user.coordinator? a.event and user.privilage_level(a.event) >= 1
      end
      can :manage, Requirement do |r|
        user.coordinator? r.activity.event and user.privilage_level(r.activity.event) >= 2
      end
      can :manage, Event do |e|
        # l = Logger.new STDOUT
        # l.info "asdfdsfasdfasdf"
        # l.info user.privilage_level(e)
        user.coordinator? e and user.privilage_level(e) >= 3
      end
      ##############
      
      can :read, Event
      can :read, Forum do |f|
        f.user? user
      end
      can :read, Activity
      can :read, Requirement

      can :create, Activity # Checking in controller if user can create the activity.

      can :create, Requirement # Check in controller

      can :update, Requirement do |r|
        user.representitive? r.activity.event
      end
      can :destroy, Requirement do |r|
        user.representitive? r.activity.event
      end
    else
      can :read, Event
    end
  end
end
