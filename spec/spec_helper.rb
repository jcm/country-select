require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'generator_spec/test_case'

Dir[Pathname.new(File.expand_path('../', __FILE__)).join('support/**/*.rb')].each { |f| require f }
Dir[Pathname.new(File.expand_path('../../', __FILE__)).join('lib/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
end
