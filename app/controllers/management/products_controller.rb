module Management
  class ProductsController < BaseController
    before_filter :load_data, :except => :index

    def model_class
      Spree::Product
    end
    
    def index
      @products = spree_current_user.provider.products
    end
    
    def new
      @product = spree_current_user.provider.products.build()
    end
    
    
    def create
      @product = spree_current_user.provider.products.build()
      @product.attributes = params[:product]
      if @product.save
        flash[:success] = flash_message_for(@product, :successfully_updated)
        redirect_to management_products_path
      else
        render :new
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
