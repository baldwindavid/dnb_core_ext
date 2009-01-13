class Hash
  def classed_values
    new_opts = {}

    each do |k, v|
      new_opts[k.to_sym] = 
        if v.is_a?(Hash)
          classed_values(v)
        else
          v.to_proper_class
        end
    end

    new_opts
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