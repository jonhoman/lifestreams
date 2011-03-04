class EmailList < ActiveRecord::Base
  validates_presence_of :name
  has_and_belongs_to_many :streams
  has_many :recipients

  before_save :parse_recipients

  class << self
    def user(user_id)
      where(:user_id => user_id)
    end
  end

  def parse_recipients
    if recipients_text
      recipients.destroy_all
      email_addresses = recipients_text.split(/\n/)
      email_addresses.each do |email_address|
        email_address.strip!
        recipients << Recipient.create(:email_address => email_address) unless email_address == ""
      end
    end
  end

  def delete_recipient(recipient)
    recipients_text.gsub!(recipient.email_address, "")
    self.save
  end
end
