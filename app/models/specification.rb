class Specification < ActiveRecord::Base
  attr_accessible :description, :specification_category_id
  
  belongs_to :specification_category

  has_many :requirements
  has_many :products, :class_name => "Spree::Product", :through => :requirements
  
  validates :specification_category, presence:true
  
end
