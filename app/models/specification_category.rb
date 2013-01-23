class SpecificationCategory < ActiveRecord::Base
  attr_accessible :code, :description
  has_many :specifications

  translates :description
  
  validates :code, presence:true, uniqueness: { case_sensitive: false }
  validates :description, presence:true
  
end
