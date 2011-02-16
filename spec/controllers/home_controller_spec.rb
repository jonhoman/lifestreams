require 'spec_helper'

describe HomeController do

  def mock_feed(stubs={})
    (@mock_feed ||= mock_model(Feed).as_null_object).tap do |feed|
      feed.stub(stubs) unless stubs.empty?
    end
  end

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

    it "assigns all feeds as @feeds" do
      Feed.stub(:user) { [mock_feed] }

      get 'dashboard'
      assigns(:feeds).should have(1).feeds
    end
  end
end
