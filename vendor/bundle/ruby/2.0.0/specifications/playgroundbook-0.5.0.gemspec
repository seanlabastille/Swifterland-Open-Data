# -*- encoding: utf-8 -*-
# stub: playgroundbook 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "playgroundbook".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ash Furrow".freeze]
  s.date = "2016-12-18"
  s.description = "Tooks for Swift Playground books on iOS, a renderer and a linter.".freeze
  s.email = "ash@ashfurrow.com".freeze
  s.executables = ["playgroundbook".freeze]
  s.files = ["bin/playgroundbook".freeze]
  s.homepage = "https://github.com/ashfurrow/playground-book-lint".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.6".freeze
  s.summary = "Lints/renders Swift Playground books.".freeze

  s.installed_by_version = "2.6.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<plist>.freeze, ["~> 3.2"])
      s.add_runtime_dependency(%q<colored>.freeze, ["~> 1.2"])
      s.add_runtime_dependency(%q<cork>.freeze, ["~> 0.1"])
    else
      s.add_dependency(%q<plist>.freeze, ["~> 3.2"])
      s.add_dependency(%q<colored>.freeze, ["~> 1.2"])
      s.add_dependency(%q<cork>.freeze, ["~> 0.1"])
    end
  else
    s.add_dependency(%q<plist>.freeze, ["~> 3.2"])
    s.add_dependency(%q<colored>.freeze, ["~> 1.2"])
    s.add_dependency(%q<cork>.freeze, ["~> 0.1"])
  end
end
