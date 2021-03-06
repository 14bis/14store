require 'spec_helper'

describe Spree::Admin::SpecificationsController do
  stub_authorization!

  describe "GET #index" do
    it "renders the :index view" do
      spree_get :index
      response.should render_template :index
    end
    
    it "assigns @specifications" do
      spree_get :index
      assigns["specifications"].should_not be_nil
    end
  end
  
  describe "GET #show" do
    it "redirects to #edit" do
      specification = FactoryGirl.create(:specification)
      spree_get :show, id: specification
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
      before { @sc = FactoryGirl.create(:specification_category)}
      it "creates a new specification" do
        expect{
          spree_post :create, specification: FactoryGirl.attributes_for(:specification, specification_category_id: @sc.id)
        }.to change(Specification, :count).by(1)
      end
      
      it "redirects to specifications index" do
        spree_post :create, specification: FactoryGirl.attributes_for(:specification, specification_category_id: @sc.id)
        response.should redirect_to spree.admin_specifications_path
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new specification" do
        expect{
          spree_post :create, specification: FactoryGirl.attributes_for(:specification, description: "")
        }.to_not change(Specification, :count)
      end
      
      it "re-renders the new method" do
        spree_post :create, specification: FactoryGirl.attributes_for(:specification, description: "")
        response.should render_template :new
      end
    end 
  end
  
end
