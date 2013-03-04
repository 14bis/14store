Spree::OrderMailer.class_eval do

  def confirm_email_to_provider(order, resend = false)
    @order = order
    subject = (resend ? "[#{t(:resend).upcase}] " : '')
    subject += "#{Spree::Config[:site_name]} #{t('order_mailer.confirm_email.subject')} ##{order.number}"
    @order.products.uniq{ |p| p.provider_id }.each do |product|
        mail(:to => product.provider.email,
             :subject => subject)
    end
  end
end
