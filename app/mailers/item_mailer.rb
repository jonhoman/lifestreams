class ItemMailer < ActionMailer::Base
  default :from => "jon@jonhoman.com"

  def update_email(item, recipient)
    @item = item
    mail :to => recipient.email_address, :subject => "New blog post, #{item.title}"
  end
end
