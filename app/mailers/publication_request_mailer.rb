class PublicationRequestMailer < ActionMailer::Base
	helper 'spree/base'

	def notify_publication_request(user, publication_request)
		@user = user
		@product = publication_request.product
		@publication_request = publication_request
		subject = "#{Spree::Config[:site_name]} #{t('publication_request_mailer.notify_publication_request.subject', 
													:product_name => @product.name)}"
		mail(:to => @user.email,
			:subject => subject)
	end
end