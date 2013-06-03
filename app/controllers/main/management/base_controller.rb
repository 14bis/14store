module Main
  module Management
    class BaseController < ApplicationController
      # include Spree::Core::ControllerHelpers

      helper 'management/navigation'
      layout '/main/layouts/management'
      
      # before_filter :authorize_management
      
      def current_ability
        @current_ability ||= ManagementAbility.new(spree_current_user)
      end
    
      protected
  #      def authorize_management
  #        record = model_class rescue Object
  #        authorize! params[:action].to_sym, record
  #      end
        
        def flash_message_for(object, event_sym)
          resource_desc = object.class.model_name.human
          resource_desc += " \"#{object.name}\"" if object.respond_to?(:name) && object.name.present?
          I18n.t(event_sym, :resource => resource_desc)
        end
    
    end
  end
end