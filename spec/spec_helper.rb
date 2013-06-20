require 'rubygems'
require 'bundler/setup'
require 'active_record'
require 'activable'
require 'generator_spec/test_case'

# paths = [File.expand_path('../../', __FILE__) + 'lib/**/*.rb']
# paths << Pathname.new(File.expand_path('../', __FILE__)).join('support/**/*.rb')
# paths.each { |p| Dir[p].each { |f| require f } }

Dir[Pathname.new(File.expand_path('../', __FILE__)).join('support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
end
