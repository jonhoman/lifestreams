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

    @stream.twitter_accounts = TwitterAccount.find(params[:twitter_account])

    if @stream.save
      redirect_to(user_root_path, :notice => 'Your stream was successfully created.')
    else
      @feeds = Feed.user(current_user)
      @twitter_accounts = TwitterAccount.user(current_user)
      render "new"
    end
  end

  def edit
    @feeds = Feed.user(current_user)
    @twitter_accounts = TwitterAccount.user(current_user)
    @stream = Stream.find(params[:id])
  end

  def update
    @stream = Stream.find(params[:id])

    if @stream.update_attributes(params[:stream])
      @stream.twitter_accounts = TwitterAccount.find(params[:twitter_account])

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
