class Hpricot::Elem
  def clean_text
    search('script').remove
    inner_text
  end
end
