class TwitterAccountsController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    @twitter_account = TwitterAccount.find(params[:id])
    @twitter_account.destroy

    redirect_to(user_root_path, :notice => 'Your twitter account was successfully deleted.')
  end
end
