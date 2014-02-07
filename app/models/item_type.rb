class ItemType < ActiveRecord::Base
  include SharedMethods
  include ActionView::Helpers::NumberHelper

  # relations
  belongs_to :group
  has_many :items

  # validations
  validates :group_id, presence: true
  validates :measure_by, inclusion: %w(volume weight unit)
  validates :name, length: { minimum: 1 }

  # scopes
  default_scope { order(name: :asc) }

  # compile some statistics on usage (for the pie charts)
  def usage_stats
    # cycle through all people to see how much they used
    usage = []
    Person.all.each do |person|
      used, unit = person.amount_of_item_type_used(self)
      if used > 0
        used = number_with_precision(used, precision: 1)
        entry = {'person_name' => person.name, 'amount_used' => used, 'unit' => unit}
        usage.append(entry)
      end
    end

    # give a nice value if nothing was used yet
    if usage.length == 0
      usage = [{'person_name' => 'not used yet', 'amount_used' => 0, 'unit' => measure_by}]
    end

    return usage
  end

  # get the stats on purchase history too
  def purchase_stats
    # cycle through all people to see how much they bought
    supplied = []
    Person.all.each do |person|
      supply, unit = person.amount_of_item_type_bought(self)
      if supply > 0
        supply = number_with_precision(supply, precision: 1)
        entry = {'person_name' => person.name, 'amount_purchased' => supply, 'unit' => unit}
        supplied.append(entry)
      end
    end

    return supplied
  end

  # and find out who should buy the next one!
  def next_buyers(group)
    users = {}
    Person.where(group: group).each do |person|
      users[person.id] = person.buyer_score(self)
    end

    # buyer = Person.find(users.sort_by{ |id, score| score }.last[0])

    potential_buyer = users.sort_by{ |id, score| score }.last
    buyer_ids = []
    for user in users
      if user[1] == potential_buyer[1]
        buyer_ids.append(user[0])
      end
    end
    buyers = Person.find(buyer_ids)

  end
end
