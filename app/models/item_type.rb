class ItemType < ActiveRecord::Base
  # relations
  has_many :items

  # validations
  validates :measure_by, inclusion: %w(volume weight unit)
  validates :name, length: { minimum: 1 }

end
