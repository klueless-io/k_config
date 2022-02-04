# frozen_string_literal: true

module KConfig
  # Configuration object for all k_* GEMs.
  class Configuration
    include KUtil::Data::InstanceVariablesToH

    attr_accessor :config_name
  end
end
