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

#  describe "GET index" do
#    it "assigns all providers as @collection" do
#      provider = FactoryGirl.create(:provider)
#      spree_get "index"
#      assigns[:collection].should include(provider)
#    end
#  end

#  describe "GET show" do
#    it "assigns the requested provider as @provider" do
#      provider = Admin::Provider.create! valid_attributes
#      get :show, {:id => provider.to_param}, valid_session
#      assigns(:provider).should eq(provider)
#    end
#  end

#  describe "GET new" do
#    it "assigns a new provider as @provider" do
#      get :new, {}, valid_session
#      assigns(:provider).should be_a_new(Admin::Provider)
#    end
#  end

#  describe "GET edit" do
#    it "assigns the requested provider as @provider" do
#      provider = Admin::Provider.create! valid_attributes
#      get :edit, {:id => provider.to_param}, valid_session
#      assigns(:provider).should eq(provider)
#    end
#  end

#  describe "POST create" do
#    describe "with valid params" do
#      it "creates a new Admin::Provider" do
#        expect {
#          post :create, {:provider => valid_attributes}, valid_session
#        }.to change(Admin::Provider, :count).by(1)
#      end

#      it "assigns a newly created provider as @provider" do
#        post :create, {:provider => valid_attributes}, valid_session
#        assigns(:provider).should be_a(Admin::Provider)
#        assigns(:provider).should be_persisted
#      end

#      it "redirects to the created provider" do
#        post :create, {:provider => valid_attributes}, valid_session
#        response.should redirect_to(Admin::Provider.last)
#      end
#    end

#    describe "with invalid params" do
#      it "assigns a newly created but unsaved provider as @provider" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        Admin::Provider.any_instance.stub(:save).and_return(false)
#        post :create, {:provider => {}}, valid_session
#        assigns(:provider).should be_a_new(Admin::Provider)
#      end

#      it "re-renders the 'new' template" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        Admin::Provider.any_instance.stub(:save).and_return(false)
#        post :create, {:provider => {}}, valid_session
#        response.should render_template("new")
#      end
#    end
#  end

#  describe "PUT update" do
#    describe "with valid params" do
#      it "updates the requested provider" do
#        provider = Admin::Provider.create! valid_attributes
#        # Assuming there are no other admin_providers in the database, this
#        # specifies that the Admin::Provider created on the previous line
#        # receives the :update_attributes message with whatever params are
#        # submitted in the request.
#        Admin::Provider.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, {:id => provider.to_param, :provider => {'these' => 'params'}}, valid_session
#      end

#      it "assigns the requested provider as @provider" do
#        provider = Admin::Provider.create! valid_attributes
#        put :update, {:id => provider.to_param, :provider => valid_attributes}, valid_session
#        assigns(:provider).should eq(provider)
#      end

#      it "redirects to the provider" do
#        provider = Admin::Provider.create! valid_attributes
#        put :update, {:id => provider.to_param, :provider => valid_attributes}, valid_session
#        response.should redirect_to(provider)
#      end
#    end

#    describe "with invalid params" do
#      it "assigns the provider as @provider" do
#        provider = Admin::Provider.create! valid_attributes
#        # Trigger the behavior that occurs when invalid params are submitted
#        Admin::Provider.any_instance.stub(:save).and_return(false)
#        put :update, {:id => provider.to_param, :provider => {}}, valid_session
#        assigns(:provider).should eq(provider)
#      end

#      it "re-renders the 'edit' template" do
#        provider = Admin::Provider.create! valid_attributes
#        # Trigger the behavior that occurs when invalid params are submitted
#        Admin::Provider.any_instance.stub(:save).and_return(false)
#        put :update, {:id => provider.to_param, :provider => {}}, valid_session
#        response.should render_template("edit")
#      end
#    end
#  end

#  describe "DELETE destroy" do
#    it "destroys the requested provider" do
#      provider = Admin::Provider.create! valid_attributes
#      expect {
#        delete :destroy, {:id => provider.to_param}, valid_session
#      }.to change(Admin::Provider, :count).by(-1)
#    end

#    it "redirects to the admin_providers list" do
#      provider = Admin::Provider.create! valid_attributes
#      delete :destroy, {:id => provider.to_param}, valid_session
#      response.should redirect_to(admin_providers_url)
#    end
#  end

end
