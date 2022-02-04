# frozen_string_literal: true

module KConfig
  # Configuration object for all k_* GEMs.
  class Configuration
    include KUtil::Data::InstanceVariablesToH
    include KLog::Logging

    attr_accessor :config_name

    def debug(*debug_extensions)
      log.section_heading(config_name) if config_name

      debug_extensions.each do |debug_extension|
        send(debug_extension) if respond_to?(debug_extension)
      end
    end
  end
end
