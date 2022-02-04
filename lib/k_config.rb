# frozen_string_literal: true

require 'k_log'
require 'k_type'

require_relative 'k_config/version'
require_relative 'k_config/configuration'

# KConfig is a configuration helper for k_* GEMs.
module KConfig
  # raise KConfig::Error, 'Sample message'
  Error = Class.new(StandardError)

  # Configuration helpers
  class << self
    attr_writer :configuration
    attr_writer :default_configuration_type

    def default_configuration_type
      @default_configuration_type ||= KConfig::Configuration
    end

    def configuration(config_name = :default)
      @configuration ||= Hash.new do |h, key|
        h[key] = default_configuration_type.new
      end
      config = @configuration[config_name]
      config.config_name = config_name if config.respond_to?(:config_name) && config.config_name.nil?
      config
    end

    def reset(config_name = :default)
      @configuration ||= Hash.new do |h, key|
        h[key] = default_configuration_type.new
      end
      config = default_configuration_type.new
      config.config_name = config_name if config.respond_to?(:config_name) && config.config_name.nil?
      @configuration[config_name] = config
    end

    def configure(config_name = :default)
      yield(configuration(config_name))
    end
  end
end

if ENV['KLUE_DEBUG']&.to_s&.downcase == 'true'
  namespace = 'KConfig::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('k_config/version') }
  version   = KConfig::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
