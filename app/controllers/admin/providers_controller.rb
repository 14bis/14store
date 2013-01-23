class Admin::ProvidersController < Admin::ResourceController
  # GET /admin/providers
  # GET /admin/providers.json
  
  def model_class
    Provider
  end
  
end
