require 'spec_helper'

describe EmailWorker do
  let :email_list do
    Factory(:email_list, :recipients_text => "jon@jonhoman.com")
  end

  let :item do
    Factory(:item, :title => "Hello, World!", :body => "My First Post", :link => "http://google.com")
  end

  let :mailer do
    double()
  end

  it "sends an email to the recipient" do
    ItemMailer.should_receive(:update_email).with(item, an_instance_of(Recipient)).once.and_return(mailer)
    mailer.stub(:deliver)

    EmailWorker.perform(item.id, email_list.id)
  end

  it "sends an email to each recipient" do
    email_list.update_attributes!(:recipients_text => "jon@jonhoman.com\njonphoman@gmail.com")

    ItemMailer.should_receive(:update_email).with(item, an_instance_of(Recipient)).twice.and_return(mailer)
    mailer.stub(:deliver)

    EmailWorker.perform(item.id, email_list.id)
  end
end
