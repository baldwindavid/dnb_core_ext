class Hash
  def classed_values
    new_opts = {}

    each do |k,v|
      new_opts[k.to_sym] = 
        if v == 'true'
          true
        elsif v == 'false'
          false
        elsif v.class == Hash
          v.classed_values
        elsif v.float?
          v.to_f
        elsif v.integer?
          v.to_i
        else
          v
        end
    end

    return new_opts
  end

end


class String
  def integer?
    to_i.to_s == self
  end

  def float?
    to_f.to_s == self
  end
  
end