class EmailListsController < ApplicationController
  before_filter :authenticate_user!, :except => 'unsubscribe'

  def new
    @email_list = EmailList.new
  end

  def create
    @email_list = current_user.email_lists.build(params[:email_list])
    
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

  def destroy
    @email_list = EmailList.find(params[:id])
    @email_list.destroy

    redirect_to user_root_path, :notice => 'Email List was successfully deleted.'
  end

  def unsubscribe
    @recipient = Recipient.find_by_hash_value(params[:hash])
    @email_list = @recipient.email_list
    
    @email_list.delete_recipient(@recipient)
  end

  def import_recipients
  end

  def load_recipients
    @email_list = current_user.email_lists.build(:name => "Imported Email List")
    @email_list.recipients_text = EmailList.create_recipients_from_file(params[:recipients][:file])
    
    if @email_list.save 
      redirect_to user_root_path, :notice => "Recipients were successfully imported."
    else
      render :action => 'new'
    end
  end
end
