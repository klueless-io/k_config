# frozen_string_literal: true

require_relative 'lib/k_config/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version  = '>= 2.7'
  spec.name                   = 'k_config'
  spec.version                = KConfig::VERSION
  spec.authors                = ['David Cruwys']
  spec.email                  = ['david@ideasmen.com.au']

  spec.summary                = 'KConfig provides configuration for multi-plugin architecture'
  spec.description            = <<-TEXT
    KConfig provides configuration for multi-plugin architecture
  TEXT
  spec.homepage               = 'http://appydave.com/gems/k_config'
  spec.license                = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri']           = spec.homepage
  spec.metadata['source_code_uri']        = 'https://github.com/klueless-io/k_config'
  spec.metadata['changelog_uri']          = 'https://github.com/klueless-io/k_config/blob/main/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required']  = 'true'

  # The `git ls-files -z` loads the RubyGem files that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  # spec.extensions    = ['ext/k_config/extconf.rb']

  spec.add_dependency 'k_log', '~> 0'
  spec.add_dependency 'k_type', '~> 0'
  spec.add_dependency 'k_util', '~> 0'
end
