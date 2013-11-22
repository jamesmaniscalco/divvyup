module SharedMethods
  def unit_choices(type)
    weights = %w(pound ounce gram)
    volumes = %w(milliliter liter cup ounce teaspoon tablespoon pinch)

    if type == "weight"
      choices = weights
    elsif type == "volume"
      choices = volumes
    elsif type == "unit"
      choices = %w(unit)
    elsif type == "all"
      choices = weights + volumes + %w(unit)
    end

    return choices
  end
end
