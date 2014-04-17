require_relative 'spec_helper'

describe Hpricot::Elem do
  describe "#clean_text" do
    let(:content) { "<td>A<script>alert('Hey')</script>B</td>" }
    let(:result)  { "AB" }
    let(:td)      { Hpricot(content).search('td').first }

    subject(:cleaned_text){ td.clean_text }

    it "should clean script" do
      expect(cleaned_text).to eq result
    end
  end
end
