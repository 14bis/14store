module Management
  class ProductsController < BaseController
    load_and_authorize_resource :find_by => :permalink, :class => "Spree::Product"
    before_filter :load_data, :except => :index
    respond_to :html
    respond_to :js, :only => [:destroy]

#    def model_class
#      Spree::Product
#    end
    
    def index
      # @products = spree_current_user.provider.products
    end
    
    def show
      session[:return_to] ||= request.referer
      redirect_to( :action => :edit )
    end
    
    def new
      # @product = spree_current_user.provider.products.build()
    end
    
    def edit
      # @product = Spree::Product.find_by_permalink(params[:id])
    end
    
    def create
      @product.attributes = params[:product]
      if @product.save
        flash[:success] = flash_message_for(@product, :successfully_updated)
        redirect_to management_products_path
      else
        render :new
      end
    end
    
    def update
      if @product.update_attributes(params[:product])
        flash[:success] = flash_message_for(@product, :successfully_updated)
        redirect_to management_products_path
      else
        render :edit
      end
    end
    
    def destroy
      if @product.destroy
        flash[:success] = flash_message_for(@product, :successfully_removed)
        respond_with(@product) do |format|
          format.html { redirect_to management_products_path }
          format.js { render :partial => "spree/admin/shared/destroy" }
        end
      else
        respond_with(@product) do |format|
          format.html { redirect_to management_products_path }
        end
      end
    end
    
    protected
    
      def load_data
        @taxons = Spree::Taxon.order(:name)
        @option_types = Spree::OptionType.order(:name)
        @tax_categories = Spree::TaxCategory.order(:name)
        @shipping_categories = Spree::ShippingCategory.order(:name)
      end
  
  end
end
