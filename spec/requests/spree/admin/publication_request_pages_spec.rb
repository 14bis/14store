require 'spec_helper'

describe "spree_admin_publication_requests_pages" do
  let(:publication_request) { FactoryGirl.create(:publication_request) }

  before {login FactoryGirl.create(:admin)}

  describe "index" do
    it "accepts the product" do
      visit spree.admin_product_publication_requests_path publication_request.product
      expect { click_link "Accept"}.to change{Spree::Product.where(:status => Spree::Product::APPROVED).count}.by(1)
    end
    it "rejects the product" do
      visit spree.admin_product_publication_requests_path publication_request.product
      expect { click_link "Reject"}.to change{Spree::Product.where(:status => Spree::Product::REJECTED).count}.by(1)
    end
  end
end