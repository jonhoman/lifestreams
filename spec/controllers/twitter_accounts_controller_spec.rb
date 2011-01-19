require 'spec_helper'

describe TwitterAccountsController do
  before(:each) do
    @user = Factory(:user)
    sign_in @user
  end

  def mock_twitter_account(stubs={})
    (@mock_twitter_account ||= mock_model(TwitterAccount).as_null_object).tap do |feed|
      twitter_account.stub(stubs) unless stubs.empty?
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested twitter_account" do
      TwitterAccount.should_receive(:find).with("37") { mock_twitter_account }
      mock_twitter_account.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the dashboard" do
      TwitterAccount.stub(:find) { mock_twitter_account }
      delete :destroy, :id => "1"
      response.should redirect_to(user_root_path)
    end
  end
end
