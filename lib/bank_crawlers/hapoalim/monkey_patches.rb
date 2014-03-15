class String
  def dateify
    Date.parse("#{self} 2014") rescue Date.today
  end

  def numerify
    self.gsub(/[,.]/, '').to_i/100.0
  end
end

class Hpricot::Elem
  def clean_text
    search('script').remove
    inner_text
  end
end
