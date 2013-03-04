Spree::OrdersController.class_eval do

  before_filter :empty, :only => [:populate]

  def edit  
    @order = current_order(true)
    associate_user
    # do not show cart (edit order)
    redirect_to checkout_state_path(@order.checkout_steps.first)
  end
  
  protected
    def empty
      if @order = current_order
        @order.empty!
      end
    end
  
end
