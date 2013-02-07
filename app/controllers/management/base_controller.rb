module Management
  class BaseController < ApplicationController
    before_filter :authorize_management
    
    def current_ability
      @current_ability ||= ManagementAbility.new(spree_current_user)
    end
  
    protected
      def authorize_management
        record = model_class rescue Object
        authorize! params[:action].to_sym, record
      end
  
  end
end
