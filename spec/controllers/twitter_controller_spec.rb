require 'spec_helper'

describe TwitterController do
  include TwitterStubs

  before(:each) do
    @user = Factory(:user)
    sign_in @user
  end

  describe "GET 'connect'" do
    before do 
      stub_oauth_request_token!
    end

    it "should redirect to twitter authorization url" do
      get 'connect'

      session[:request_token].should == 't'
      session[:request_token_secret].should == 's'
      response.location.should =~ /api.twitter.com/
    end
  end

  describe "GET 'callback'" do
    before do
      stub_oauth_access_token!
    end

    it "should authenticate with twitter" do
      get :callback, :oauth_verifier => 'some_key', :handle => 'some_handle'

      response.should be_redirect
    end
  end
end
