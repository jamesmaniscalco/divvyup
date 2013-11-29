module ApplicationHelper
  def share_ratio_class(ratio)
    if ratio > 1.25
      return "high-ratio"
    elsif ratio < 0.66
      return "low-ratio"
    else
      return ""
    end
  end

  def share_ratio_formatted(ratio)
    if ratio == 'infinity'
      return ratio
    else
      return number_with_precision ratio, precision: 2
    end
  end
end
