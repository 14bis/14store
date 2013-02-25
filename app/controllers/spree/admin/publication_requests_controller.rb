module Spree
  module Admin

    class PublicationRequestsController < ResourceController
      belongs_to 'spree/product', :find_by => :permalink
      
      def model_class
        PublicationRequest
      end

      def update
        ActiveRecord::Base.transaction do
          if params[:accept].present?
            @product.available_on = Time.now
            @product.save
          end
          @publication_request.close
          @publication_request.save
        end
        redirect_to admin_product_publication_requests_path
      end

    end
    
  end
end