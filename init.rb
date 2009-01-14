class Array
  
  def values_to_proper_class
    inject([]) do |memo, value|     
      memo << 
        if value.is_a?(Hash)
          value.values_to_proper_class
        elsif value.is_a?(Array)
          value.values_to_proper_class
        else
          value.to_proper_class
        end
    end
  end
  
end

class Hash
  def values_to_proper_class
    inject({}) do |memo, values|
      key, value = values
      memo[key.to_sym] = 
        if value.is_a?(Hash)
          value.values_to_proper_class
        elsif value.is_a?(Array)
          value.values_to_proper_class
        else
          value.to_proper_class
        end
      memo
    end
  end
  
  def values_to_proper_class!
    
  end

end


class String
  def to_proper_class
    if boolean?
      to_b
    else
      float? || integer? || self
    end
  end
  
  def integer?
    (value = to_i).to_s == self && value
  end

  def float?
    (value = to_f).to_s == self && value
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