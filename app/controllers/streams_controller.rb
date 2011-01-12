class StreamsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @stream = Stream.new
    @feeds = Feed.user(current_user)
    @twitter_accounts = TwitterAccount.user(current_user)
  end

  def create
    @stream = Stream.new(params[:stream])
    @stream.user_id = current_user.id
    @stream.save
    redirect_to :action => "index"
  end

  def index
    @streams = Stream.all
  end
end
