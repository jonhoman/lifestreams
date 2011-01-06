require 'spec_helper'

describe TwitterController do

  describe "GET 'connect'" do
    xit "should be successful" do
      get 'connect'
      response.should be_success
    end
  end

end
