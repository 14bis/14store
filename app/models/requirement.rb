class Requirement < ActiveRecord::Base
  attr_accessible :value

  belongs_to :product, :class_name => "Spree::Product"
  belongs_to :specification
  
  validates :product,  presence: true
  validates :specification,  presence: true
end