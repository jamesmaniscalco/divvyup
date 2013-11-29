class Person < ActiveRecord::Base
  include SharedMethods

  # validations
  validates :name, length: { minimum: 1 }

  # relations
  has_many :uses
  has_many :items

  # scopes
  default_scope order(name: :asc)

  # get the amount used for a particular item
  def amount_of_item_used(item)
    used = 0.0
    unit = base_unit(item.item_type.measure_by)

    item.uses.each do |use|
      if use.person_id == id
        used += use.amount_used
      end
    end

    return [used, unit]
  end
end
