class Admin::RequirementsController < Admin::ResourceController
  belongs_to 'spree/product', :find_by => :permalink
  #before_filter :load_data
  
  def model_class
    Requirement
  end

end
