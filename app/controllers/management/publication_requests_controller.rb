module Management
  class PublicationRequestsController < BaseController
    load_and_authorize_resource :product, :find_by => :permalink, :class => 'Spree::Product'
  	load_and_authorize_resource :publication_request, :through => :product

    def create
    	@product.publication_requests.create
    	flash[:success] = flash_message_for(@product, :submited_for_aproval)
        redirect_to management_products_path
    end

    def update
      @publication_request.cancel
      if @publication_request.save
        flash[:success] = flash_message_for(@publication_request, :successfully_canceled)
		redirect_to management_products_path
      else
		redirect_to management_products_path
      end
    end

  end	
end