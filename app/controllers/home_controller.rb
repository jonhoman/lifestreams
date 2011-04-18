class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard

  def index
  end

  def dashboard
    @twitter_accounts = current_user.twitter_accounts
    @feeds = current_user.feeds
    @streams = current_user.streams
    @email_lists = current_user.email_lists
    @facebook_accounts = current_user.facebook_accounts
  end
end
