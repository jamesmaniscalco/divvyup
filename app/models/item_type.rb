class ItemType < ActiveRecord::Base
  # relations
  has_many :items

  # validations
  validates :measure_by, inclusion: {'volume', 'weight', 'unit'}

end
