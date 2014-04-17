class String
  def dateify
    Date.parse("#{self} 2014") rescue Date.today
  end

  def numerify
    self.gsub(/[,.]/, '').to_i/100.0
  end
end
