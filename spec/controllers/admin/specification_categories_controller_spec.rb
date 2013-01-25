require 'spec_helper'

describe Admin::SpecificationCategoriesController do
  stub_authorization!
  
 describe "GET #index" do
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
    
    it "assigns @specification_categories" do
      #specification_category = FactoryGirl.create(:specification_category)
      get :index
      #assigns["specification_categories"].should include(specification_category)
      assigns["specification_categories"].should_not be_nil
    end
  end
  
  describe "GET #show" do
    it "redirects to #edit" do
      specification_category = FactoryGirl.create(:specification_category)
      get :show, id: specification_category
      response.should redirect_to edit_admin_specification_category_url(specification_category)
    end
  end
  
  describe "GET #new" do
    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new specification_category" do
        expect{
          post :create, specification_category: FactoryGirl.attributes_for(:specification_category)
        }.to change(SpecificationCategory, :count).by(1)
      end
      
      it "redirects to specification_categories index" do
        post :create, specification_category: FactoryGirl.attributes_for(:specification_category)
        response.should redirect_to admin_specification_categories_path
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new specification_category" do
        expect{
          post :create, specification_category: FactoryGirl.attributes_for(:specification_category, code: "")
        }.to_not change(SpecificationCategory, :count)
      end
      
      it "re-renders the new method" do
        post :create, specification_category: FactoryGirl.attributes_for(:specification_category, code: "")
        response.should render_template :new
      end
    end 
  end
  
end
