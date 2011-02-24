class EmailListsController < ApplicationController
  def new
    @email_list = EmailList.new
  end
end
