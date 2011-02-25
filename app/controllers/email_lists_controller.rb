class EmailListsController < ApplicationController
  def new
    @email_list = EmailList.new
  end

  def create
    @email_list = EmailList.new(params[:email_list])
    @email_list.user_id = current_user.id
    
    if @email_list.save
      redirect_to(user_root_path, :notice => 'Email list was successfully created.')
    else
      render :action => "new"
    end
  end

  def show
    @email_list = EmailList.find(params[:id])
  end

  def edit
    @email_list = EmailList.find(params[:id])
  end

  def update
    @email_list = EmailList.find(params[:id])
    
    if @email_list.update_attributes(params[:email_list])
      redirect_to(user_root_path, :notice => 'Email list was successfully updated.')
    else 
      render :action => 'edit'
    end
  end
end
