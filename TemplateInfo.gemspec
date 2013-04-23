# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'TemplateInfo/version'

Gem::Specification.new do |spec|
  spec.name          = "TemplateInfo"
  spec.version       = TemplateInfo::VERSION
  spec.authors       = ["i5ting"]
  spec.email         = ["shiren1118@126.com"]
  spec.description   = %q{TemplateInfo.plist file creator}
  spec.summary       = %q{TemplateInfo.plist is ruby gem for create TemplateInfo.plist file.TemplateInfo.plist file is used in xcode 4 template files.}
  spec.homepage      = "https://github.com/i5ting/TemplateInfo.plist"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
