module Spree
  module Admin

    class PublicationRequestsController < ResourceController
      belongs_to 'spree/product', :find_by => :permalink
      
      def model_class
        PublicationRequest
      end

      def update
        if params[:accept].present?
          @product.status = Spree::Product::APPROVED
          @product.available_on = Time.now
        else
          @product.status = Spree::Product::REJECTED
        end
        @publication_request.status = PublicationRequest::CLOSED
        save_each_within_transaction [ @product, @publication_request ] 
        redirect_to admin_product_publication_requests_path
      end

    end
  end
end