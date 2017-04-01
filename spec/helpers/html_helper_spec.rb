require 'rails_helper'

describe HtmlHelper do
  describe "truncate_url" do
    it "return the http base url without trailing" do
      url = "http://www.example.com/trailing/item"

      expect(truncate_url(url)).to eq("http://www.example.com")
    end

    it "return the base url without trailing" do
      url = "www.example.com/trailing/item"

      expect(truncate_url(url)).to eq("http://www.example.com")
    end
  end

  describe "date_format" do
    it "return specifies the date format" do
      date = DateTime.new(2017, 04, 01, 20, 10, 0)
      expect(date_format(date)).to eq "วันที่: 1/4/17 เวลา 20:10 น."
    end
  end
end
