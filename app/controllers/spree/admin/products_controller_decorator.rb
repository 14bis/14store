Spree::Admin::ProductsController.class_eval do
  before_filter :remove_available_on, :only => [:create, :update]
  
  def remove_available_on
    params[:product][:available_on] = @product.available_on
  end

end