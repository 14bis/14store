include ActionView::Helpers::TextHelper
Spree::Product.class_eval do
  attr_accessible :provider_id, :specification_ids, :trial_period

  belongs_to :provider
  has_many :requirements
  has_many :specifications, :through => :requirements

  validates :provider,  :presence => true
  validates :trial_period, :presence => true
  validates_numericality_of :trial_period, :less_than_or_equal_to => 85, :greater_than_or_equal_to => 0

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

end
