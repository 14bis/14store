require "spec_helper"

describe "Store Provider pages" do
  let(:provider) { FactoryGirl.create(:provider) }

  describe "show" do
    before { visit spree.provider_path provider}
    it "shows provider's info" do
      page.should have_content provider.name
    end
  end
end