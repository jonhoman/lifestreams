class StreamsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @stream = Stream.new
    @feeds = Feed.user(current_user)
  end

  def create
    @stream = Stream.new(params[:stream])
    @stream.save
    redirect_to :action => "index"
  end

  def index
    @streams = Stream.all
  end
end
