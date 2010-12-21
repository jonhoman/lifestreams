class Stream < ActiveRecord::Base
  has_one :source
  accepts_nested_attributes_for :source
end
