class Provider < ActiveRecord::Base
  # organizational
  attr_accessible :name, :full_name, :code, :website
  # contact
  attr_accessible :email, :phone1, :phone2, :fax,
    :address1, :address2, :city, :zipcode, :state_id, :country_id
  belongs_to :state, :class_name => "Spree::State" 
  belongs_to :country, :class_name => "Spree::Country"
  
  # TODO
  # As long as we are going to use email validation on other parts of the project
  # Refactor this
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :products, :class_name => "Spree::Product"
  
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  

# Another way to validate inserting personalized error message
 
#  def validate 
#    errors.add(:email, t("provider.email_invalid")) if (VALID_EMAIL_REGEX.match(self.email))
#  end
  
  
end
