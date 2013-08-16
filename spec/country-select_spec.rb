require 'spec_helper'

describe 'country-select' do
  include ActionView::Helpers::FormOptionsHelper

  def options_for_select(options, selected)
    options.to_s
  end

  describe 'generationg options for select' do
    it 'generates an array of countries to select' do
      country_options_for_select.should_not be_empty
    end

    it "separates priority countries" do
      options = country_options_for_select nil, nil
      options['---------'].should be_nil

      options = country_options_for_select nil, []
      options['---------'].should be_nil

      options = country_options_for_select nil, ['BRA']
      options['---------'].should_not be_nil
      options[/^\[\["Brazil", "BRA"\]\]/].should_not be_nil # priority countries at the begining
    end
  end
end
