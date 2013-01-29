module Spree
  module Admin

    class RequirementsController < ResourceController
      belongs_to 'spree/product', :find_by => :permalink
      #before_filter :load_data
      
      def model_class
        Requirement
      end

    end
    
  end
end
