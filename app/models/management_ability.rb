class ManagementAbility
  include CanCan::Ability
  
  def initialize(user)
    user ||= Spree::User.new # guest user

    if user.respond_to?(:has_spree_role?) && user.has_spree_role?('provider')
      can :index, Spree::Product
      can :create, Spree::Product
      can [:read, :update, :destroy], Spree::Product do |product|
        product.provider.user == spree_current_user
      end
    else
      
    end
  end
  
end
