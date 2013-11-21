class Item < ActiveRecord::Base
  # relations
  belongs_to :person
  belongs_to :item_type
  has_many :uses

end
