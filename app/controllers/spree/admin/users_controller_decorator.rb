Spree::Admin::UsersController.class_eval do

  before_filter :load_provider, :only => [:new, :edit]
  before_filter :remove_provider, :only => [:create, :update]
  
  def load_provider
    @user.provider ||= @user.build_provider
  end
  
  def remove_provider
    if !params["user"]["spree_role_ids"].include?(ROLE_PROVIDER.id.to_s)
      params["user"].delete "provider_attributes"
      @user.provider = nil
    end
  end
    
end
