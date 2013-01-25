require 'spec_helper'

describe Admin::RequirementsController do
  stub_authorization!
  
  before { @product = FactoryGirl.create(:product) }

  describe "GET #index" do
    it "renders the :index view" do
      get :index, :product_id => @product.permalink
      response.should render_template :index
    end
    
    it "should find product by permalink" do
      get :index, :product_id => @product.permalink
      assigns["product"].should == @product
    end
    
    it "should not find product by id" do
      expect {
        get :index, :product_id => @product.id
      }.to raise_error(NoMethodError)
    end
    
  end
  
end
