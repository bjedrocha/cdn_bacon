# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cdn_bacon/version'

Gem::Specification.new do |spec|
  spec.name          = "cdn_bacon"
  spec.version       = CdnBacon::VERSION
  spec.authors       = ["Bart Jedrocha"]
  spec.email         = ["bart.jedrocha@gmail.com"]
  spec.description   = %q{Rails helpers for loading Javascript and CSS from a CDN and falling back to local where available}
  spec.summary       = %q{Rails helpers for loading JS and CSS from various CDNs}
  spec.homepage      = "http://github.com/bjedrocha/cdn_bacon"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
