include ApplicationHelper

def login(user)
  visit spree.login_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Login"
end

def stub_authorize!
  before do
    controller ||= Management::BaseController.any_instance
    controller.should_receive(:authorize!).any_number_of_times.and_return(true)
  end
end
