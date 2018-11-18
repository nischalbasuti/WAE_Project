class UserManagementController < ApplicationController
  authorize_resource :class => false, :except=> :profile
  skip_before_action :verify_authenticity_token, :only => :update_users


  def profile    
  end

  def edit
    @user = current_user.id    
  end

  def update
    respond_to do |format|
      if @user.update
        format.html { redirect_to "/user_management/profile", notice: 'Profile was successfully updated.' }
        
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end


  
  def index
  end

  def user_manage_features
  end

  def user_statistics
  end

  def basic_user_page
  end

  def show
    @users = User.order(created_at: :desc).all
    # Get all distinct categories.
    @role_options = User.GLOBAL_ROLES

  end

  def ban
    @user = User.find_by_id(params[:id])
    @user.ban
    @user.save
    redirect_back(fallback_location: "/user_management/show")
    flash.alert = "The user has been banned!"
  end

  def unban
    @user = User.find_by_id(params[:id])
    @user.global_role = "member"
    @user.save
    redirect_back(fallback_location: "/user_management/show")
    flash.alert = "The user has been unbanned!"
  end

  def update_users
    # Update the roles of the users. 
    logger = Logger.new STDOUT
    params[:users].each do |u| 
      user = User.find(u[:id].to_i)
      if user.set_global_role u[:global_role] 
        user.save
      else
        logger.info "invalid role"
        flash.alert = "invalid role"
      end
    end

    render json: {message: "user roles updated."}
    # redirect_to "/user_management/show"
  end

  def statistic_users
    @users = User.all
  end

  

end
