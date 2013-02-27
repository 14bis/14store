module Management
  class PublicationRequestsController < BaseController
    load_and_authorize_resource :product, :find_by => :permalink, :class => 'Spree::Product'
  	load_and_authorize_resource :publication_request, :through => :product

    def create
      @product.status = Spree::Product::SUBMITTED
      save_each_within_transaction [ @product, @publication_request ] 
    	flash[:success] = flash_message_for(@product, :submited_for_aproval)
      redirect_to management_products_path
    end

    def update
      @publication_request.status = PublicationRequest::CANCELED
      @product.status = Spree::Product::NOT_SUBMITTED
      save_each_within_transaction [ @product, @publication_request ] 
      flash[:success] = flash_message_for(@publication_request, :successfully_canceled)
		  redirect_to management_products_path
    end

  end	
end