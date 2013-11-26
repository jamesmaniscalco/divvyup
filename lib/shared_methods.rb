module SharedMethods
  def unit_choices(type)
    weights = ['pound', 'ounce', 'gram']
    volumes = ['milliliter', 'liter', 'cup', 'fluid ounce', 'teaspoon', 'tablespoon', 'pinch']

    if type == "weight"
      choices = weights
    elsif type == "volume"
      choices = volumes
    elsif type == "unit"
      choices = ['unit']
    elsif type == "all"
      choices = weights + volumes + ['unit']
    end

    return choices
  end

  def base_unit(type)
    if type == "weight"
      return 'gram'
    elsif type == "volume"
      return 'milliliter'
    elsif type == "unit"
      return 'unit'
    end
  end
end
