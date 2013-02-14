require 'uri'

class Provider < ActiveRecord::Base
  # organizational
  attr_accessible :name, :full_name, :code, :website
  # contact
  attr_accessible :email, :phone1, :phone2, :fax,
    :address1, :address2, :city, :zipcode, :state_id, :country_id
  belongs_to :state, :class_name => "Spree::State" 
  belongs_to :country, :class_name => "Spree::Country"
  belongs_to :user, :class_name => "Spree::User"
  
  has_many :products, :class_name => "Spree::Product"
  
#  validates :user, presence: true
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :phone1, format: { with: VALID_PHONE_REGEX }, :allow_blank => true
  validates :phone2, format: { with: VALID_PHONE_REGEX }, :allow_blank => true
  validates :fax, format: { with: VALID_PHONE_REGEX }, :allow_blank => true
  validates :website, format: { with: URI::regexp }, :allow_blank => true
  

# Another way to validate inserting personalized error message

#  def validate 
#    errors.add(:email, t("provider.email_invalid")) if (VALID_EMAIL_REGEX.match(self.email))
#  end
  
  
end
