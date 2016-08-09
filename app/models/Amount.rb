class Amount

  def self.default
    self == (Post.price*1000) 
  end
end
