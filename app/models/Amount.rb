class Amount

  def self.default
    self == @amount.to_i*1000 
  end
end
