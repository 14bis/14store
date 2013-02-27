class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    return unauthorized
  end
  
  def unauthorized
    if spree_current_user
      flash[:error] = t(:authorization_failure)
      redirect_to '/unauthorized'
    else
      session[:user_return_to] = request.url
      redirect_to spree_login_path
    end
  end

  def save_each_within_transaction objects
    ActiveRecord::Base.transaction do
      objects.each(&:save!)
    end
  end
  
end
