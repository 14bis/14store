include ActionView::Helpers::TextHelper
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
  
  attr_accessible :provider_id, :specification_ids, :trial_period

  belongs_to :provider
  has_many :requirements
  has_many :specifications, :through => :requirements
  has_many :publication_requests, :dependent => :destroy

  validates :provider,  :presence => true
  validates :trial_period, :presence => true
  validates_numericality_of :trial_period, :less_than_or_equal_to => 85, :greater_than_or_equal_to => 0

  validate :approved_and_available?
  def approved_and_available?
    if available_on.present?
      errors.add(:status, "must be approved if the product is available") unless status == Spree::Product::APPROVED
    elsif status == Spree::Product::APPROVED
      errors.add(:available_on, "must be set if the product is approved") unless available_on.present?
    end
  end

  def have_trial_period?
    if self.trial_period > 0
      true
    else
      false
    end
  end

  def trial_message
    if self.have_trial_period?
      "Available to free use for #{pluralize( self.trial_period / 7, 'week' )} ."
    end
  end

  def trial_full_message
    if self.have_trial_period?
      "The #{self.name} is available to free use for #{pluralize( self.trial_period / 7, 'week' )} ."
    end
  end
  
  def approval_request
    return publication_requests.last unless publication_requests.nil? || publication_requests.empty? 
  end

end
