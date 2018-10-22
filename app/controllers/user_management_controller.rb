class UserManagementController < ApplicationController

  def show
    @users = User.all
  end
end
