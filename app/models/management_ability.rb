class ManagementAbility
  include CanCan::Ability
  
  def initialize(user)
    user ||= Spree::User.new # guest user

    if user.respond_to?(:has_spree_role?) && user.has_spree_role?('provider')
      can [:read, :create, :update, :destroy], Spree::Product, :provider_id => user.provider.id
      can [:create, :update] , PublicationRequest, :product => { :provider_id => user.provider.id }
    else
      
    end
  end
  
end
