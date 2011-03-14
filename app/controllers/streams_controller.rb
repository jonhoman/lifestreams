class StreamsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @stream = Stream.new
  end

  def create
    @stream = Stream.new(params[:stream])
    @stream.user_id = current_user.id

    if @stream.save
      redirect_to(user_root_path, :notice => 'Your stream was successfully created.')
    else
      render "new"
    end
  end

  def edit
    @stream = Stream.find(params[:id])
  end

  def update
    @stream = Stream.find(params[:id])

    if @stream.update_attributes(params[:stream])
      @stream.update_attributes(:active => true) # only activate stream if successful update

      redirect_to(user_root_path, :notice => 'Stream was successfully updated.')
    else
      render "edit"
    end
  end

  def destroy
    @stream = Stream.find(params[:id])
    @stream.destroy

    redirect_to(user_root_path, :notice => 'Stream was successfully deleted.')
  end

  def show
    @stream = Stream.find(params[:id])
  end
end
