module Management
  class PublicationRequestsController < BaseController
    load_and_authorize_resource :product, :find_by => :permalink, :class => 'Spree::Product'
  	load_and_authorize_resource :publication_request, :through => :product

    def create
      @product.status = Spree::Product::SUBMITTED
      save_each_within_transaction [ @product, @publication_request ] 
      # I am not sure if this is improving performance to respond faster to the user
      Thread.new { deliver_notify_publication_request_to_admins }
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

    protected
      def deliver_notify_publication_request_to_admins
        begin
          Spree::User.includes(:spree_roles).where('spree_roles.name' => 'admin').each do |user|
            PublicationRequestMailer.notify_publication_request(user, @publication_request).deliver
          end
        rescue Exception => e
          logger.error("#{e.class.name}: #{e.message}")
          logger.error(e.backtrace * "\n")
        end
      end
  end	
end