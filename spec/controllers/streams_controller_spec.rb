require 'spec_helper.rb'
describe StreamsController do
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
      response.should redirect_to streams_path
    end
    
    it "should create a new stream" do
      post :create, "stream" => {"name" => "Test2"}
      assigns(:stream).should_not be_nil
      assigns(:stream).name.should == "Test2"
    end
  end
end
