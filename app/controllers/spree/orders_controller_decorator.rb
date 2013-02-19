Spree::OrdersController.class_eval do

  before_filter :empty, :only => [:populate]

  def edit  
    @order = current_order(true)
    associate_user
    redirect_to checkout_state_path(@order.checkout_steps.first)
  end
  
  def empty
    if @order = current_order
      @order.empty!
    end
  end
  
end
