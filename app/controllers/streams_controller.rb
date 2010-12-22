class StreamsController < ApplicationController
  def new
    @stream = Stream.new
    source = @stream.build_source
    source.destinations.build
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
