# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{stowaway}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Emilio Cavazos"]
  s.date = %q{2010-02-16}
  s.default_executable = %q{stowaway}
  s.email = %q{ejcavazos@gmail.com}
  s.executables = ["stowaway"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.md",
     "Rakefile",
     "TODO.txt",
     "VERSION.yml",
     "bin/stowaway",
     "lib/stowaway/file.rb",
     "lib/stowaway/fshelpyhelp.rb",
     "lib/stowaway/locator.rb",
     "lib/stowaway/matcher.rb",
     "lib/stowaway/options.rb",
     "lib/stowaway/runner.rb",
     "lib/stowaway/status.rb",
     "lib/stowaway/sweeper.rb",
     "spec/data/testfile1.txt",
     "spec/data/testfile2.txt",
     "spec/lib/file_spec.rb",
     "spec/lib/locator_spec.rb",
     "spec/lib/options_spec.rb",
     "spec/lib/sweeper_spec.rb",
     "spec/runner_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "stowaway.gemspec"
  ]
  s.homepage = %q{http://www.iamneato.com}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Locate files in a web project that aren't being used.}
  s.test_files = [
    "spec/lib/file_spec.rb",
     "spec/lib/locator_spec.rb",
     "spec/lib/options_spec.rb",
     "spec/lib/sweeper_spec.rb",
     "spec/runner_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

