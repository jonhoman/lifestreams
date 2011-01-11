class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard

  def index
  end

  def dashboard
    @twitter_accounts = TwitterAccount.user(current_user)
    @feeds = Feed.user(current_user)
  end
end
