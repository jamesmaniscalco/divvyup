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

  # same, but for item types
  def amount_of_item_type_used(item_type)
    total_used = 0.0
    unit = base_unit(item_type.measure_by)

    item_type.items.each do |item|
      used, unit = self.amount_of_item_used(item) # check how much has been used
      if used > 0 # if it was more than zero,
        total_used += used
      end
    end

    return [total_used, unit]
  end

  # this one's a bit tricker.  it's the total amount used of all items of this type purchased by this person.
  def amount_of_item_type_bought(item_type)
    total_used_from_purchases = 0.0
    unit = base_unit(item_type.measure_by)

    # parse the relevant items from the user's purchased items
    items_to_consider = items.where(:item_type => item_type)

    items_to_consider.each do |item|
      total_used_from_purchases += item.amount_used[:amount].to_f
    end

    return [total_used_from_purchases, unit]
  end

  # ok, put them together to get the share ratio.  like on bittorrent!
  def share_ratio(item_type)
    amount_bought = amount_of_item_type_bought(item_type)[0]
    amount_used = amount_of_item_type_used(item_type)[0]

    # check that our calculations make sense
    if amount_used > 0
      # if the amounts bought and used are positive, we have a nice fraction.
      ratio = amount_bought / amount_used
    else
      # if the amount used is zero, then the ratio is infinite
      ratio = 'infinity'
    end

    return ratio
  end

  # algorithm to determine someone's 'buyer score' for a particular item type.  A higher score means you're more likely to have to buy it.
  def buyer_score(item_type)
    ratio = share_ratio(item_type)
    share_delta = amount_of_item_type_used(item_type)[0] - amount_of_item_type_bought(item_type)[0]
    if ratio == 'infinity' or ratio > 1
      score = 0
    else
      score = share_delta ** 1.5 / (ratio + 0.01)
    end
  end
end
