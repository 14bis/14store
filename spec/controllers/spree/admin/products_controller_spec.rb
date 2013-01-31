require 'spec_helper'

describe Spree::Admin::ProductsController do
  stub_authorization!
  
  it "update requirements of a product" do
    product = FactoryGirl.create(:product)
    specification = FactoryGirl.create(:specification)
    spree_put :update, id: product, product: product.attributes = {:specification_ids => [specification.id]}
    product.reload
    product.specifications.should include(specification)
  end

end
