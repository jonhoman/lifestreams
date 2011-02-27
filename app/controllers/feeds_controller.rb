class FeedsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @feed = Feed.find(params[:id])
  end

  def new
    @feed = Feed.new
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def create
    @feed = Feed.new(params[:feed])
    @feed.user_id = current_user.id

    if @feed.save
      redirect_to user_root_path, :notice => 'Feed was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @feed = Feed.find(params[:id])

    if @feed.update_attributes(params[:feed])
      redirect_to user_root_path, :notice => 'Feed was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

   redirect_to user_root_path, :notice => 'Feed was successfully deleted.'
  end
end
