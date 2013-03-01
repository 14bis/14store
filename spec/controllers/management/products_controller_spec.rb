require 'spec_helper'

describe Management::ProductsController do

  before(:all) { @user_provider = FactoryGirl.create(:user_provider) }
  after(:all) { 
    @user_provider.provider.destroy
    @user_provider.destroy 
  }
  before { stub_management_login! @user_provider }
  let(:my_product) { FactoryGirl.create(:product, :provider => @user_provider.provider) }

  describe "GET #index" do
    describe "page" do
      it "renders the management layout" do
        get :index
        response.should render_template("layouts/management")
      end
    end
    
    it "assigns owner @products" do
      my_product
      other_product = FactoryGirl.create(:product)
      get :index
      assigns["products"].should include(my_product)
      assigns["products"].should_not include(other_product)
    end
    
  end
  
  describe "GET #edit" do
    context "with authorized user" do
      it "renders the edition page" do
        get :edit, id: my_product.permalink
        response.should render_template :edit
      end
    end
    
    context "with unauthorized user" do
      it "redirects to unauthorized page" do
        get :edit, id: FactoryGirl.create(:product).permalink
        response.should redirect_to spree.unauthorized_path
      end
    end
  end

  describe "PUT #update" do
    it "doesn't update available_on field" do
      now = Time.now
      put :update, id: my_product.permalink, product: {:available_on => now}
      my_product.reload.available_on.to_i.should_not == now.to_i
    end
  end
  
  describe "GET #show" do
    it "redirects to #edit" do
      get :show, id: my_product.permalink
      response.should redirect_to :action => :edit
    end
  end
  
  describe "xhr #delete" do
    it "deletes a provider" do
      xhr :delete, :destroy, :id => my_product.permalink, :format => "html"
      @user_provider.provider.products.reload.should_not include(my_product)
    end
    it "doesn't delete the product if destroy returns false and redirects to the index" do
      Spree::Product.any_instance.stub(:destroy).and_return(false)
      xhr :delete, :destroy, :id => my_product.permalink, :format => "html"
      @user_provider.provider.products.reload.should include(my_product)
      response.should redirect_to management_products_path
    end
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new product" do
        expect{
          post :create, product: FactoryGirl.attributes_for(:product)
        }.to change(Spree::Product, :count).by(1)
      end
      it "doesn't set the field available_on" do
        post :create, product: FactoryGirl.attributes_for(:product, :available_on => Time.now)
        Spree::Product.last.available_on.should be_nil
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new product" do
        expect{
          post :create, product: FactoryGirl.attributes_for(:product, name: "")
        }.to_not change(Spree::Product, :count)
      end
    end 
  end

end
