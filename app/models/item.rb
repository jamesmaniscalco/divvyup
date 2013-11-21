class Item < ActiveRecord::Base
  # relations
  belongs_to :person
  belongs_to :item_type
  has_many :uses

  # validations
  validates :person_id, presence: true
  validates :item_type_id, presence: true

end
