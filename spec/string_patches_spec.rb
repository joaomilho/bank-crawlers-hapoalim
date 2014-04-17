require_relative 'spec_helper'

describe String do
  describe ".dateify" do
    it "should parse Hapoalim's date format" do
      expect("01/01".dateify).to eq Date.new(2014,1,1)
    end
  end
end
