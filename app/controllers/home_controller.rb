class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard

  def index
  end

  def dashboard
    @twitter_accounts = TwitterAccount.all
  end
end
