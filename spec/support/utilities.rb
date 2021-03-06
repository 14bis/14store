include ApplicationHelper

def login(user)
  visit spree.login_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Login"
end

def stub_authorize!
  let(:ability_user) do
    stub_model(Spree::User) do |user|
      user.stub(:provider).and_return(stub_model(Provider))
    end
  end
  
  before do
    controller ||= Main::Management::BaseController.any_instance
    controller.stub(:spree_current_user).and_return(ability_user)
    controller.should_receive(:authorize!).any_number_of_times.and_return(true)
  end
end

def stub_login (user)
  Main::Management::BaseController.any_instance.stub(:spree_current_user).and_return(user)
  Spree::Admin::BaseController.any_instance.stub(:spree_current_user).and_return(user)
end

def skeep_authorize!
  before do
    Main::Management::BaseController.any_instance.should_receive(:authorize!).any_number_of_times.and_return(true)
    Spree::Admin::BaseController.any_instance.should_receive(:authorize!).any_number_of_times.and_return(true)
  end
end
