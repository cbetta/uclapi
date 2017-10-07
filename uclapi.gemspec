
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "uclapi/version"

Gem::Specification.new do |spec|
  spec.name          = "uclapi"
  spec.version       = UCLAPI::VERSION
  spec.authors       = ["Cristiano Betta"]
  spec.email         = ["cristiano@betta.io"]

  spec.summary       = "A wrapper for the UCL API"
  spec.description   = "A wrapper for the UCL API"
  spec.homepage      = "https://uclapi.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "awesome_print", "~> 1.8.0"
end
