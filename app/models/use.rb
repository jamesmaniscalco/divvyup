class Use < ActiveRecord::Base
  # relations
  belongs_to :person
  belongs_to :item

  # validations
  validates_numericality_of :amount, :greater_than => 0

end
