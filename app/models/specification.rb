class Specification < ActiveRecord::Base
  attr_accessible :description, :specification_category_id
  belongs_to :specification_category
  
  validates :specification_category, presence:true
  
end
