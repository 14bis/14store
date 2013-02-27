class PublicationRequest < ActiveRecord::Base
  OPEN = 0
  CLOSED = 1
  CANCELED = 2
  STATUSES = { OPEN => :open , CLOSED => :closed, CANCELED => :canceled }

  attr_protected :status
  validates_inclusion_of :status, :in => STATUSES.keys,
      :message => "must be in #{STATUSES.values.join ', '}"
  
  belongs_to :product, :class_name => 'Spree::Product'

end
