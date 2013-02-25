class PublicationRequest < ActiveRecord::Base
  attr_protected :status
  belongs_to :product, :class_name => 'Spree::Product'

  def open?
  	status.nil? || status == 0
  end

  def closed?
  	status == 1
  end

  def canceled?
  	status ==2
  end

  def open
  	self.status = 0
  end

  def close
  	self.status = 1
  end

  def cancel
  	self.status = 2
  end

end
