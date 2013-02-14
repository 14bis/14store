Spree::Order.class_eval do
  checkout_flow do
    go_to_state :payment, :if => lambda { |order| order.payment_required? }
    go_to_state :confirm, :if => lambda { |order| order.confirmation_required? }
    go_to_state :complete
  end

  state_machine.after_transition :to => :complete,
                                 :do => :deliver_order_confirmation_email_to_provider

  # If true, causes the payment step to happen during the checkout process
  def payment_required?
   self.products.each {| product | return false if product.trial_period > 0}
   return true
  end

  # If true, causes the confirmation step to happen during the checkout process
  def confirmation_required?
    return true
  end

  def deliver_order_confirmation_email_to_provider
    begin
      Spree::OrderMailer.confirm_email_to_provider(self).deliver
    rescue Exception => e
      logger.error("#{e.class.name}: #{e.message}")
      logger.error(e.backtrace * "\n")
    end
  end

end
