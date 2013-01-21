Spree::Product.class_eval do
  attr_accessible :provider_id, :specification_ids
  
  belongs_to :provider
  has_many :requirements
  has_many :specifications, :through => :requirements

  validates :provider,  presence: true
  
end
