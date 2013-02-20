Spree::Product.class_eval do
  attr_accessible :provider_id, :specification_ids, :trial_period

  belongs_to :provider
  has_many :requirements
  has_many :specifications, :through => :requirements

  validates :provider,  presence: true

  def have_trial_period?
    if self.trial_period > 0
      true
    else
      false
    end
  end

  def trial_short_message
    if self.trial_period > 0
      "Available for trial"
    end
  end

end
