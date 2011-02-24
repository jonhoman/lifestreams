class EmailListsController < ApplicationController
  def new
    @email_list = EmailList.new
  end

  def create
    @email_list = EmailList.new(params[:email_list])
    @email_list.user_id = current_user.id
    @email_list.save

    redirect_to(user_root_path, :notice => 'Feed was successfull created.')
  end

  def show
    @email_list = EmailList.find(params[:id])
  end
end
