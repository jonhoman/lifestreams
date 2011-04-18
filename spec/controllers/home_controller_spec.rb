require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'dashboard'" do
    before(:each) do
      @user = Factory(:user)
      sign_in @user
    end

    it "should be successful" do
      get 'dashboard'
      response.should be_success
    end
  end
end
