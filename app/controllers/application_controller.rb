class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    return unauthorized
  end
  
  def unauthorized
    redirect_to '/unauthorized'
  end

  def save_each_within_transaction objects
    ActiveRecord::Base.transaction do
      objects.each(&:save!)
    end
  end
  
end
