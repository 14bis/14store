Spree::StoreController.class_eval do

  def unauthorized
    if spree_current_user
      flash.now[:error] = t(:authorization_failure)
      render 'spree/shared/unauthorized', :layout => Spree::Config[:layout], :status => 401
    else
      session[:user_return_to] = request.url
      redirect_to spree_login_path
    end
  end

end