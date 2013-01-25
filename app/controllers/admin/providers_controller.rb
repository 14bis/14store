class Admin::ProvidersController < Admin::ResourceController
  # GET /admin/providers
  # GET /admin/providers.json
  
  def model_class
    Provider
  end
  
  def show
    session[:return_to] ||= request.referer
    redirect_to( main_app.edit_admin_provider_url(params[:id]) )
  end
  
end
