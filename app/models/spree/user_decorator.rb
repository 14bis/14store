Spree::User.class_eval do
  
  has_one :provider
  accepts_nested_attributes_for :provider
  attr_accessible :provider_attributes

  # Do validation at controller level 
  # because spree associates the roles after the user being saved
  # validate :provider_presence
  # def provider_presence
  #   if !spree_roles.find {|r| r.name == "provider"}.nil?
  #     errors.add(:provider, "can't be nil") unless !provider.nil?
  #   else
  #     errors.add(:provider, "must be nil") unless provider.nil?
  #   end
  # end
  
end
