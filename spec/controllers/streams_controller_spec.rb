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
      assigns(:book).should_not 
    end
  end
end
