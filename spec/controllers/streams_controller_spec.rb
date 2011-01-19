require 'spec_helper.rb'

describe StreamsController do
  before(:each) do
    @user = Factory(:user)
    sign_in @user
  end

  def mock_stream(stubs={})
    (@mock_stream ||= mock_model(Stream).as_null_object).tap do |stream|
      stream.stub(stubs) unless stubs.empty?
    end
  end

  describe "#new" do
    before do
      get :new
    end
    it "should be succesful" do
      response.should be_success
    end

    it "should create a stream object" do
      assigns(:stream).should_not be_nil
    end
  end

  describe "#create" do
    it "should redirect to the stream list page" do
      post :create, "stream" => {"name" => "Test1"}
      response.should redirect_to(user_root_path)
    end
    
    it "should create a new stream" do
      post :create, "stream" => {"name" => "Test2" }
      assigns(:stream).should_not be_nil
      assigns(:stream).name.should == "Test2"
    end
  end

  describe "#index" do
    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have a list of streams" do
      get :index
      assigns(:streams).should_not be_nil
    end
  end

  describe "#edit" do
    it "assign the requested stream as @stream" do
      Stream.stub(:find).with("1") { mock_stream }
      get :edit, :id => "1"
      assigns(:stream).should be(mock_stream)
    end
  end

  describe "#update" do
    it "updates the requested stream" do
      Stream.should_receive(:find).with("1") { mock_stream }
      mock_stream.should_receive(:update_attributes).with({'these' => 'params'})
      put :update, :id => "1", :stream => {'these' => 'params'}
    end
  end

  describe "#destroy" do
    it "deletes the requested stream" do
      Stream.should_receive(:find).with("1") { mock_stream }
      mock_stream.should_receive(:destroy)
      delete :destroy, :id => "1"
    end

    it "redirects to the dashboard" do
      Stream.stub(:find) { mock_stream }
      delete :destroy, :id => "1"
      response.should redirect_to(user_root_path)
    end
  end

end
