require 'spec_helper'

describe Spree::Admin::SpecificationCategoriesController do
  stub_authorization!
  
 describe "GET #index" do
    it "renders the :index view" do
      spree_get :index
      response.should render_template :index
    end
    
    it "assigns @specification_categories" do
      #specification_category = FactoryGirl.create(:specification_category)
      spree_get :index
      #assigns["specification_categories"].should include(specification_category)
      assigns["specification_categories"].should_not be_nil
    end
  end
  
  describe "GET #show" do
    it "redirects to #edit" do
      specification_category = FactoryGirl.create(:specification_category)
      spree_get :show, id: specification_category
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
      it "creates a new specification_category" do
        expect{
          spree_post :create, specification_category: FactoryGirl.attributes_for(:specification_category)
        }.to change(SpecificationCategory, :count).by(1)
      end
      
      it "redirects to specification_categories index" do
        spree_post :create, specification_category: FactoryGirl.attributes_for(:specification_category)
        response.should redirect_to spree.admin_specification_categories_path
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new specification_category" do
        expect{
          spree_post :create, specification_category: FactoryGirl.attributes_for(:specification_category, code: "")
        }.to_not change(SpecificationCategory, :count)
      end
      
      it "re-renders the new method" do
        spree_post :create, specification_category: FactoryGirl.attributes_for(:specification_category, code: "")
        response.should render_template :new
      end
    end 
  end
  
end
