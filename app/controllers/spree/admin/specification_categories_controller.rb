class Spree::Admin::SpecificationCategoriesController < Spree::Admin::ResourceController
  # GET /admin/providers
  # GET /admin/providers.json
  
  def model_class
    SpecificationCategory
  end
  
  def show
    session[:return_to] ||= request.referer
    redirect_to( :action => :edit )
  end
  
end
