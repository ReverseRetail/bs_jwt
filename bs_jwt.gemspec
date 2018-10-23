# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bs_jwt/version'

Gem::Specification.new do |spec|
  spec.name          = 'bs_jwt'
  spec.version       = BsJwt::VERSION
  spec.licenses      = ['Nonstandard'] # see https://choosealicense.com/no-permission/
  spec.authors       = ['Karol M', 'Burkhard Vogel-Kreykenbohm']
  spec.email         = ['dmuhafc(at)gmail.com', 'b.vogel(at)buddyandselly.com']
  spec.summary       = 'Simple library for verifying Auth0 JWTs.'
  spec.homepage      = 'https://www.reverse-retail.com'
  spec.metadata      = { 'source_code_uri' => 'https://gitlab.com/ReverseRetail/bs_jwt' }

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'factory_bot', '>= 4.0', '<= 6.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.59.0'
  spec.add_development_dependency 'webmock', '~> 3.0'

  spec.add_dependency 'activesupport', '>= 4.0', '<= 6.0'
  spec.add_dependency 'faraday', '>= 0.8', '<= 2.0'
  spec.add_dependency 'json-jwt', '~> 1.9'
end
