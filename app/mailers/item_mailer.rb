class ItemMailer < ActionMailer::Base
  default :from => "jon@jonhoman.com"

  def update_email(item, recipient)
    @item = item
    user = User.find item.feed.user_id
    mail :from user.email_address, 
         :to => recipient.email_address, 
         :subject => "New blog post, #{item.title}"
  end
end
