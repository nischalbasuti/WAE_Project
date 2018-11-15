class LoginsController < ApplicationController
  def new
  end

  def create
    # if user = 
      user = authenticate_with_google
      if user.save
        sign_in user
        flash[:error] = "user signed in"
      end
      # redirect_to new_session_url(user)
      # cookies.signed[:user_id] = user.id
      redirect_to '/'
    # else
    #   redirect_to new_session_url(:user)#, alert: 'authentication_failed'
    # end
  end

  private
    def authenticate_with_google
      if flash[:google_sign_in_token].present?
        googleIdentity = GoogleSignIn::Identity.new(flash[:google_sign_in_token])
        u = User.find_by google_id: googleIdentity.user_id
        if u.nil?
          new_user = User.new(:email => googleIdentity.email_address, :password => 'password', :password_confirmation => 'password')
          new_user.email = googleIdentity.email_address
          new_user.google_id = googleIdentity.user_id
          return new_user
        end
        return u
      end
    end
end
