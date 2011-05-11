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
    @feed = current_user.feeds.build(params[:feed])

    if @feed.save
      respond_to do |format|
        format.html { redirect_to user_root_path, :notice => 'Feed was successfully created.' }
        format.js
      end
    else
      render :action => "new"
    end
  end

  def update
    @feed = Feed.find(params[:id])
    #current_user.feeds.find

    if @feed.update_attributes(params[:feed])
      redirect_to user_root_path, :notice => 'Feed was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to user_root_path, :notice => 'Feed was successfully deleted.' }
      format.js
    end
  end
end
