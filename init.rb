class Array
  
  def values_to_proper_class(symbolize_keys = true)
    inject([]) do |memo, value|     
      memo << 
        if [Array, Hash].include? value.class
          value.values_to_proper_class(symbolize_keys)
        else
          value.to_proper_class
        end
    end
  end
  
end


class Hash
  
  def values_to_proper_class(symbolize_keys = true)
    inject({}) do |memo, values|
      key, value = values
      key = symbolize_keys ? key.to_sym : key.to_s
      memo[key] = 
        if [Array, Hash].include? value.class
          value.values_to_proper_class(symbolize_keys)
        else
          value.to_proper_class
        end
      memo
    end
  end

end


class String
  
  def to_proper_class
    if boolean?
      to_b
    elsif float?
      to_f
    elsif integer?
      to_i
    else
      self
    end
  end
  
  # Does this value represent an integer?
  def integer?
    to_i.to_s == self
  end
  
  # Does this value represent a float?
  def float?
    to_f.to_s == self
  end 

  def boolean?
    to_b.to_s == self
  end
  
  def to_b
    if self == 'true'
      true
    elsif self == 'false'
      false
    end
  end
  
end