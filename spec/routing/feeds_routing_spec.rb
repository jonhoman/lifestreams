require "spec_helper"

describe FeedsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/feeds" }.should route_to(:controller => "feeds", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/feeds/new" }.should route_to(:controller => "feeds", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/feeds/1" }.should route_to(:controller => "feeds", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/feeds/1/edit" }.should route_to(:controller => "feeds", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/feeds" }.should route_to(:controller => "feeds", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/feeds/1" }.should route_to(:controller => "feeds", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/feeds/1" }.should route_to(:controller => "feeds", :action => "destroy", :id => "1")
    end

  end
end
