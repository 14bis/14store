Spree::Product.class_eval do
  belongs_to :provider
  attr_accessible :provider_id

  validates :provider,  presence: true
  
end
