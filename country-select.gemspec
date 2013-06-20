Gem::Specification.new do |s|
	s.name					=	'country-select'
	s.version				= '1.2.3'
	s.date					= '2012-03-02'
	s.summary				= 'Country select box'
	s.description		= 'Provides a form helper to insert a country select box using the ISO 3166 country list'
	s.authors				=	[ 'Michael Koziarski', 'James Dean Shepherd', "Jonathan O'Connor", "Diego Aguir Selzlein" ]
	s.email					= 'jamesds2007@gmail.com'
	s.files					= `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
	s.homepage			= 'http://github.com/nerde/country-select'
  s.require_paths = ["lib"]
  s.license       = "MIT"
end
