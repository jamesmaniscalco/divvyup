class Use < ActiveRecord::Base
  include SharedMethods

  # relations
  belongs_to :person
  belongs_to :item

  # validations
  validates_numericality_of :amount, :greater_than => 0
  validates :unit, is_unit_type: true

  # scopes
  default_scope order(created_at: :desc)

  # method to report usage amount in base unit (gram, milliliter, unit)
  def amount_used
    # countable units
    if unit == 'unit'
      return amount
    # volume
    elsif unit == 'milliliter'
      return amount
    elsif unit == 'liter'
      return amount * 1000.0
    elsif unit == 'cup'
      return amount * 236.6
    elsif unit == 'fluid ounce'
      return amount * 29.57
    elsif unit == 'teaspoon'
      return amount * 4.929
    elsif unit == 'tablespoon'
      return amount * 14.79
    elsif unit == 'pinch'
      return amount * 0.2
    # weight
    elsif unit == 'gram'
      return amount
    elsif unit == 'ounce'
      return amount * 28.35
    elsif unit == 'pound'
      return amount * 453.6
    end
  end

end
