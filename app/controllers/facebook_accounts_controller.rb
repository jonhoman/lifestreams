class FacebookAccountsController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    @facebook_account = FacebookAccount.find(params[:id])
    @facebook_account.destroy

    redirect_to user_root_path, :notice => "Your facebook account was succcessfully removed."
  end
end
