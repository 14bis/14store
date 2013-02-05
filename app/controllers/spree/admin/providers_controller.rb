module Spree
  module Admin

    class ProvidersController < ResourceController
      before_filter :load_data, :except => [:index, :show]
      
      def model_class
        Provider
      end
      
      def show
        session[:return_to] ||= request.referer
        redirect_to( :action => :edit )
      end
      
      def load_data
        @available_countries = [Spree::Country.find_or_create_by_iso_and_name('BR', 'Brazil'), Spree::Country.find_or_create_by_iso_and_name('US', 'United States')]
        @available_states = []
        @available_countries.each do |country|
          @available_states = @available_states + country.states
        end
      end
      
    end

  end
end
