class Recipient < ActiveRecord::Base
  belongs_to :email_list
end
