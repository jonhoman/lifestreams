class EmailWorker
  @queue = :email

  class << self
    def perform(item_id, email_list_id)
      item = Item.find(item_id)
      email_list = EmailList.find(email_list_id)

      email_list.recipients.each do |recipient|
        ItemMailer.update_email(item, recipient).deliver
      end
    end
  end
end
