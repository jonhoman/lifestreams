class Source < ActiveRecord::Base
  has_many :destinations
  accepts_nested_attributes_for :destinations
  belongs_to :stream
end
