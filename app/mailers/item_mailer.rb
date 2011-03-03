class ItemMailer < ActionMailer::Base
  default :from => "jon@jonhoman.com"

  def update_email(item, recipient)
    @item = item
    @feed = item.feed
    user = User.find @feed.user_id

    mail :from => user.email, 
         :to => recipient.email_address, 
         :subject => "New blog post from #{@feed.title}"
  end
end
