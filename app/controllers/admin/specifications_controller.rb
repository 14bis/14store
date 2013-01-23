class Admin::SpecificationsController < Admin::ResourceController
  # GET /admin/providers
  # GET /admin/providers.json
  
  def model_class
    Specification
  end
  
end
