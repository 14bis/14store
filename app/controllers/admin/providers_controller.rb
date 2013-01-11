class Admin::ProvidersController < Spree::Admin::ResourceController
  # GET /admin/providers
  # GET /admin/providers.json
  
  def model_class
    Provider
  end
  
  def collection_url(options = {})
    if parent_data.present?
      main_app.polymorphic_url([:admin, parent, model_class],
  options)
    else
      main_app.polymorphic_url([:admin, model_class], options)
    end
  end 
  
end
