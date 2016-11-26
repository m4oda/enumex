require File.expand_path('../lib/enumex/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'enumex'
  gem.version       = Enumex::VERSION
  gem.authors       = ['m4oda']
  gem.email         = 'e5ww2sze@gmail.com'
  gem.description   = 'Enumex is a utility for Enumerator.'
  gem.summary       = 'Enumex is a utility for Enumerator.'
  gem.homepage      = 'https://github.com/m4oda/enumex'
  gem.license       = 'MIT'
  gem.require_paths = ['lib']
  gem.files         = %w(README.md enumex.gemspec)
  gem.files        += Dir['lib/**/*.rb']
end
