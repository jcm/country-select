require 'spec_helper'
# require 'generators/country-select/install_generator'

describe CountrySelect::Generators::InstallGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "copies i18n file" do
    assert_file "config/locales/countries.en.yml"
    assert_file "config/locales/countries.pt-BR.yml"
  end
end
