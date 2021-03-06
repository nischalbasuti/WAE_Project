class ProfileController < ApplicationController
	def update
		@user = current_user
		@user.nationality = params[:nationality]
		@user.department = Department.find(params[:department_id])
		if @user.save
			flash[:notice] = "Your profile updated"
		else
			flash[:error] = "Your profile is not updated"
		end
		
		redirect_to "/user_management/profile"
		
	end

  def events
  	# @e = Event.order(:name).page params[:page]
    @events = current_user.events.order(:name).page params[:page]

  end
end
