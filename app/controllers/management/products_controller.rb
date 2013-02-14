module Management
  class ProductsController < BaseController
  
    def model_class
      Spree::Product
    end
    
    def index
      @products = spree_current_user.provider.products
    end
  
  end
end
