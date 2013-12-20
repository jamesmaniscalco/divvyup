class Item < ActiveRecord::Base
  include SharedMethods
  include ActionView::Helpers::NumberHelper

  # relations
  belongs_to :person
  belongs_to :item_type
  belongs_to :group
  has_many :uses

  # validations
  validates :person_id, presence: true
  validates :item_type_id, presence: true
  validates :group_id, presence: true
  validates :comment, length: { maximum: 100 }
  validate :groups_match?

  # scopes
  default_scope { order(finished: :asc, created_at: :desc) }
  scope :available, -> { where(finished: false) }
  scope :finished, -> { where(finished: true) }

  # before save hooks
  before_save :set_default_finished_flag
  def set_default_finished_flag
    self.finished ||= false
    true
  end

  # method to get how much has been used in total
  def amount_used
    total = 0.0
    uses.each do |use|
      total += use.amount_used
    end

    return {amount: number_with_precision(total, precision: 1), unit: base_unit(item_type.measure_by)}
  end

  # compile some statistics on usage (for the pie chart)
  def usage_stats
    # cycle through all people to see how much they used
    usage = []
    unit = base_unit(item_type.measure_by)
    Person.all.each do |person|
      used, unit = person.amount_of_item_used(self) # check how much has been used
      if used > 0 # if it was more than zero,
        used = number_with_precision(used, precision: 1)
        entry = {'person_name' => person.name, 'amount_used' => used, 'unit' => unit}
        usage.append(entry)
      end
    end

    # give a nice value if nothing was used yet
    if usage.length == 0
      usage = [{'person_name' => 'not used yet', 'amount_used' => 0, 'unit' => unit}]
    end

    return usage
  end

  def groups_match?
    if person.group.id != group.id
      errors.add(:person, "must be in your group")
    end
    if item_type.group.id != group.id
      errors.add(:item_type, "must belong to your group")
    end
  end

end
