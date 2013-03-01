require 'spec_helper'

describe Spree::Admin::ProvidersController do
  stub_authorization!

  describe "GET #index" do
    it "renders the :index view" do
      spree_get :index
      response.should render_template :index
    end
    
    it "assigns @providers" do
      #provider = FactoryGirl.create(:provider)
      spree_get :index
      #assigns["providers"].should include(provider)
      assigns["providers"].should_not be_nil
    end
  end
  
  describe "GET #show" do
    it "redirects to #edit" do
      provider = FactoryGirl.create(:provider)
      spree_get :show, id: provider
      response.should redirect_to :action => :edit
    end
  end
  
  describe "GET #new" do
    it "renders the :new view" do
      spree_get :new
      response.should render_template :new
    end
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new provider" do
        expect{
          spree_post :create, provider: FactoryGirl.attributes_for(:provider)
        }.to change(Provider, :count).by(1)
      end
      
      it "redirects to providers index" do
        spree_post :create, provider: FactoryGirl.attributes_for(:provider)
        response.should redirect_to spree.admin_providers_path
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new provider" do
        expect{
          spree_post :create, provider: FactoryGirl.attributes_for(:provider, name: "")
        }.to_not change(Provider, :count)
      end
      
      it "re-renders the new method" do
        spree_post :create, provider: FactoryGirl.attributes_for(:provider, name: "")
        response.should render_template :new
      end
    end 
  end

end
