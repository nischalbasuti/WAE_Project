class UserManagementController < ApplicationController

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
  end

  def ban
    @user = User.find_by_id(params[:id])
    @user.global_role = "ban"
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


  def statistic_users
    @users = User.all
  end

end
