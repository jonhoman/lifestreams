class Recipient < ActiveRecord::Base
  belongs_to :email_list

  after_create :generate_hash

  def to_s
    "#{self.id}#{self.email_address}"
  end

  private 

  def generate_hash
    hash = Digest::SHA2.new << self.to_s
    self.update_attributes :hash_value => hash.hexdigest
  end
end

# == Schema Information
#
# Table name: recipients
#
#  id            :integer         not null, primary key
#  email_address :string(255)
#  email_list_id :integer
#

