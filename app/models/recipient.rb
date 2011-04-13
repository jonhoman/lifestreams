class Recipient < ActiveRecord::Base
  belongs_to :email_list
end

# == Schema Information
#
# Table name: recipients
#
#  id            :integer         not null, primary key
#  email_address :string(255)
#  email_list_id :integer
#

