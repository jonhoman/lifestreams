class EmailList < ActiveRecord::Base
  validates_presence_of :name
  has_and_belongs_to_many :streams
  has_many :recipients

  before_save :parse_recipients

  before_destroy :deactivate_stream

  def deactivate_stream
    streams.each do |stream| 
      if stream.email_lists.count == 1 && stream.total_destination_count == 1 
        stream.update_attributes(:active => false)
      end
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

  class << self
    def create_recipients_from_file(file)
      contents = file.read
    end
  end
end

# == Schema Information
#
# Table name: email_lists
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  name            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  recipients_text :text
#

