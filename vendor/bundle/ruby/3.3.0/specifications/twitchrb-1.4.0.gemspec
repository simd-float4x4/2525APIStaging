# -*- encoding: utf-8 -*-
# stub: twitchrb 1.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "twitchrb".freeze
  s.version = "1.4.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "homepage_uri" => "https://deanpcmad.com", "source_code_uri" => "https://github.com/deanpcmad/twitchrb" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dean Perry".freeze]
  s.bindir = "exe".freeze
  s.date = "2024-08-02"
  s.email = ["dean@deanpcmad.com".freeze]
  s.homepage = "https://deanpcmad.com".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.5.11".freeze
  s.summary = "A Ruby library for interacting with the Twitch Helix API".freeze

  s.installed_by_version = "3.5.15".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<faraday>.freeze, ["~> 2.0".freeze])
end
