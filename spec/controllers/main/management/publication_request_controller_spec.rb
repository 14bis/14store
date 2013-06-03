require 'spec_helper'

describe Main::Management::PublicationRequestsController do
  skeep_authorize!

  let(:product) { FactoryGirl.create(:product) }
  let(:publication_request) { FactoryGirl.create(:publication_request) }

  describe "POST #create" do
    it "creates a new publication request with status :open" do
      expect { post :create, :product_id => product.permalink }
         .to change{PublicationRequest.where(:status => PublicationRequest::OPEN).count}.by(1)
    end
    it "changes the product status to :submitted" do
      expect { post :create, :product_id => product.permalink }
         .to change{Spree::Product.where(:status => Spree::Product::SUBMITTED).count}.by(1)
    end
  end

  describe "PUT #update" do
    it "changes the publication request status to :canceled" do
      expect { put :update, :id => publication_request,:product_id => publication_request.product.permalink }
         .to change{PublicationRequest.where(:status => PublicationRequest::CANCELED).count}.by(1)
    end
    it "changes the product status to :not_submitted" do
      expect { put :update, :id => publication_request, :product_id => publication_request.product.permalink }
         .to change{Spree::Product.where(:status => Spree::Product::NOT_SUBMITTED).count}.by(1)
    end
  end

end