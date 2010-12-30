require 'spec_helper'

describe FeedsController do

  def mock_feed(stubs={})
    (@mock_feed ||= mock_model(Feed).as_null_object).tap do |feed|
      feed.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all feeds as @feeds" do
      Feed.stub(:all) { [mock_feed] }
      get :index
      assigns(:feeds).should eq([mock_feed])
    end
  end

  describe "GET show" do
    it "assigns the requested feed as @feed" do
      Feed.stub(:find).with("37") { mock_feed }
      get :show, :id => "37"
      assigns(:feed).should be(mock_feed)
    end
  end

  describe "GET new" do
    it "assigns a new feed as @feed" do
      Feed.stub(:new) { mock_feed }
      get :new
      assigns(:feed).should be(mock_feed)
    end
  end

  describe "GET edit" do
    it "assigns the requested feed as @feed" do
      Feed.stub(:find).with("37") { mock_feed }
      get :edit, :id => "37"
      assigns(:feed).should be(mock_feed)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created feed as @feed" do
        Feed.stub(:new).with({'these' => 'params'}) { mock_feed(:save => true) }
        post :create, :feed => {'these' => 'params'}
        assigns(:feed).should be(mock_feed)
      end

      it "redirects to the created feed" do
        Feed.stub(:new) { mock_feed(:save => true) }
        post :create, :feed => {}
        response.should redirect_to(feed_url(mock_feed))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved feed as @feed" do
        Feed.stub(:new).with({'these' => 'params'}) { mock_feed(:save => false) }
        post :create, :feed => {'these' => 'params'}
        assigns(:feed).should be(mock_feed)
      end

      it "re-renders the 'new' template" do
        Feed.stub(:new) { mock_feed(:save => false) }
        post :create, :feed => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested feed" do
        Feed.should_receive(:find).with("37") { mock_feed }
        mock_feed.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :feed => {'these' => 'params'}
      end

      it "assigns the requested feed as @feed" do
        Feed.stub(:find) { mock_feed(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:feed).should be(mock_feed)
      end

      it "redirects to the feed" do
        Feed.stub(:find) { mock_feed(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(feed_url(mock_feed))
      end
    end

    describe "with invalid params" do
      it "assigns the feed as @feed" do
        Feed.stub(:find) { mock_feed(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:feed).should be(mock_feed)
      end

      it "re-renders the 'edit' template" do
        Feed.stub(:find) { mock_feed(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested feed" do
      Feed.should_receive(:find).with("37") { mock_feed }
      mock_feed.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the feeds list" do
      Feed.stub(:find) { mock_feed }
      delete :destroy, :id => "1"
      response.should redirect_to(feeds_url)
    end
  end

end
