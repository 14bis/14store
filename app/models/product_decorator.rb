Spree::Product.class_eval do
  attr_accessible :provider_id, :specification_ids
  
  belongs_to :provider
  has_many :requirements
  has_many :specifications, :through => :requirements
  has_many :publication_requests

  validates :provider,  presence: true

  def approval_request
  	return publication_requests.last unless publication_requests.nil? || publication_requests.empty? 
  end

  def status
    if available_on.nil?
      if publication_requests.nil? || publication_requests.empty?
        return PRODUCT_STATUS[:not_submited_for_approval]
      elsif approval_request.open?
        return PRODUCT_STATUS[:submited_for_approval]
      elsif approval_request.closed?
        return PRODUCT_STATUS[:rejected]
      else #canceled
        return PRODUCT_STATUS[:not_submited_for_approval]
      end
    else
      return PRODUCT_STATUS[:approved]
    end
  end
  
end
