class Use < ActiveRecord::Base
  include SharedMethods

  # relations
  belongs_to :person
  belongs_to :item

  # validations
  validates_numericality_of :amount, :greater_than => 0
  validates :unit, is_unit_type: true

end
