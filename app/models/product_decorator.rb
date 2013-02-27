Spree::Product.class_eval do

  self.const_set( "NOT_SUBMITTED", 0 )
  self.const_set( "SUBMITTED", 1 )
  self.const_set( "REJECTED", 2 )
  self.const_set( "APPROVED", 3 )
  self.const_set( "STATUSES", { Spree::Product::NOT_SUBMITTED => :not_submitted,
                                Spree::Product::SUBMITTED => :submitted,
                                Spree::Product::REJECTED => :rejected,
                                Spree::Product::APPROVED => :approved } )

  attr_protected :status
  validates_inclusion_of :status, :in => Spree::Product::STATUSES.keys,
      :message => "must be in #{Spree::Product::STATUSES.values.join ', '}"
  # just a helper method for the view
  def status_sym
    Spree::Product::STATUSES[status]
  end

  attr_accessible :provider_id, :specification_ids
  
  belongs_to :provider
  has_many :requirements
  has_many :specifications, :through => :requirements
  has_many :publication_requests, :dependent => :destroy

  validates :provider,  presence: true

  def approval_request
  	return publication_requests.last unless publication_requests.nil? || publication_requests.empty? 
  end
  
end
