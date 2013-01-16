class Admin::SpecificationCategoriesController < Admin::ResourceController
  # GET /admin/providers
  # GET /admin/providers.json
  
  def model_class
    SpecificationCategory
  end
  
end
