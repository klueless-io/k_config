# frozen_string_literal: true

require_relative 'k_config/version'

module KConfig
  # raise KConfig::Error, 'Sample message'
  Error = Class.new(StandardError)

  # Your code goes here...
end

if ENV['KLUE_DEBUG']&.to_s&.downcase == 'true'
  namespace = 'KConfig::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('k_config/version') }
  version   = KConfig::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
