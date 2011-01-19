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
    redirect_to(user_root_path, :notice => 'Your stream was successfully created.')
  end

  def index
    @streams = Stream.all
  end

  def edit
    @feeds = Feed.user(current_user)
    @twitter_accounts = TwitterAccount.user(current_user)
    @stream = Stream.find(params[:id])
  end

  def update
    @stream = Stream.find(params[:id])

    if @stream.update_attributes(params[:stream])
      redirect_to(user_root_path, :notice => 'Stream was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @stream = Stream.find(params[:id])
    @stream.destroy

    redirect_to(user_root_path, :notice => 'Stream was successfully deleted.')
  end
end
