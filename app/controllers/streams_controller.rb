class StreamsController < ApplicationController
  def new
    @destination = Destination.new
    @source = Source.new
    @stream = Stream.new
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
