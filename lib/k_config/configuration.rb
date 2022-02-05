# frozen_string_literal: true

module KConfig
  # Configuration object for all k_* GEMs.
  #
  # Hooks:
  #   You can use hooks to add your own customizations to configuration extensions.
  class    Configuration
    include KUtil::Data::InstanceVariablesToH
    include KLog::Logging

    attr_accessor :config_name

    # Initialize configuration.
    #
    # Will call #{configuration_key}_initialize method if it exists.
    def initialize
      self.class.registered_keys.each do |key|
        method = "#{key}_initialize".to_sym
        send(method) if respond_to?(method)
      end
    end

    # Debug configuration is used for debugging.
    #
    # Will call #{configuration_key}_debug method if it exists.
    def debug
      log.section_heading(config_name) if config_name

      self.class.registered_keys.each do |key|
        method = "#{key}_debug".to_sym
        send(method) if respond_to?(method)
      end
    end

    # Initialize_copy, used during clone.
    #
    # Will call #{configuration_key}_initialize_copy method if it exists.
    def initialize_copy(orig)
      self.class.registered_keys.each do |key|
        method = "#{key}_initialize_copy".to_sym
        send(method, orig) if respond_to?(method)
      end
    end

    class << self
      def registered_keys
        @registered_keys ||= []
      end

      # Register configuration extension key
      #
      # This key provides a unique method name prefix to common methods such as debug and initialize_copy
      def register(key, extension)
        if registered_keys.include?(key)
          puts "Key #{key} already registered ... skipping"
          return registered_keys
        end

        include(extension)
        registered_keys << key
      end
    end
  end
end
