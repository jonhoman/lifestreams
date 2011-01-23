class Item < ActiveRecord::Base
  belongs_to :feed

  def <=> other
    published_date <=> other.published_date 
  end
end
