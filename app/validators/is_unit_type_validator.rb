class IsUnitTypeValidator < ActiveModel::EachValidator
  include SharedMethods

  def validate_each(record, attribute, value)
    choices = unit_choices(record.item.item_type.measure_by)
    unless choices.include?(value)
      record.errors[attribute] << (options[:message] || value + " isn't a valid unit")
    end
  end
end
