require 'spec_helper'

describe Management::ProductsController do

  describe "GET #index" do
  
    describe "page" do
      stub_authorize!
      it "renders the management layout" do
        get :index
        response.should render_template("layouts/management")
      end
    end
    
    it "assigns owner @products" do
      user = FactoryGirl.create(:user_provider)
      my_product = FactoryGirl.create(:product, :provider => user.provider)
      other_product = FactoryGirl.create(:product)
      controller.stub(:spree_current_user).and_return(user)
      get :index
      assigns["products"].should include(my_product)
      assigns["products"].should_not include(other_product)
    end
    
  end

end
