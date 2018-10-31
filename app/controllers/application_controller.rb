class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error]  = "Access denied."
    # render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    redirect_to root_url
  end
end
