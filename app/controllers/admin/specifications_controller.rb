class Admin::SpecificationsController < Admin::ResourceController
  # GET /admin/providers
  # GET /admin/providers.json
  
  def model_class
    Specification
  end
  
  def show
    session[:return_to] ||= request.referer
    redirect_to( main_app.edit_admin_specification_url(params[:id]) )
  end
  
end
