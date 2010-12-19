class StreamsController < ApplicationController
  def new
    @stream = Stream.new
  end
end
