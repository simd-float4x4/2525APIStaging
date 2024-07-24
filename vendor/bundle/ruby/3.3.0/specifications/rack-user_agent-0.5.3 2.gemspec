# -*- encoding: utf-8 -*-
# stub: rack-user_agent 0.5.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rack-user_agent".freeze
  s.version = "0.5.3".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Takashi Kokubun".freeze]
  s.date = "2022-01-22"
  s.description = "Rack::Request extension for handling User-Agent.".freeze
  s.email = ["takashikkbn@gmail.com".freeze]
  s.homepage = "https://github.com/k0kubun/rack-user_agent".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.22".freeze
  s.summary = "Rack::Request extension for handling User-Agent.".freeze

  s.installed_by_version = "3.5.15".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<rack>.freeze, [">= 1.5".freeze])
  s.add_runtime_dependency(%q<woothee>.freeze, [">= 1.0.0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 1.10".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 10.0".freeze])
  s.add_development_dependency(%q<pry>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rack-test>.freeze, [">= 0".freeze])
end
