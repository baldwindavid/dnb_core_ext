class Hash
  def classed_values
    new_opts = {}

    each do |k,v|
      if v == 'true'
        new_opts[k.to_sym] = true
      elsif v == 'false'
        new_opts[k.to_sym] = false
      elsif v.class == Hash
        new_opts[k.to_sym] = v.classed_values
      elsif v.represents_f?
        new_opts[k.to_sym] = v.to_f
      elsif v.represents_i?
        new_opts[k.to_sym] = v.to_i
      else
        new_opts[k.to_sym] = v
      end
    end

    return new_opts
  end

end


class String
  # Does this value represent an integer?
  def represents_i?
    i_value = self.to_i
    # is the string converted to int not equal to zero (because it might be a string)
    if i_value != 0
      # are we sure this isn't actually a float?
      return (i_value - self.to_f) == 0
    elsif i_value == 0
      # is the value equal to the int value converted to_s?
      return self == i_value.to_s
    end
  end

  # Does this value represent a float?
  def represents_f?
    f_value = self.to_f
    # is this not equal to zero and also not actually an integer?
    return (f_value != 0) && (f_value.to_s == self)
  end
  
end