# frozen_string_literal: true

module CustomConfigExtension
  attr_accessor :custom1
  attr_accessor :custom2

  def my_custom_debug
    log.kv 'custom1', custom1
    log.kv 'custom2', custom2
  end
end

KConfig::Configuration.include(CustomConfigExtension)

RSpec.describe 'KConfig::Configuration->Debug' do
  subject { instance.debug(:my_custom_debug) }

  let(:instance) { KConfig.configuration }

  before do
    instance.config_name = :test
    instance.custom1 = 'Custom 1'
    instance.custom2 = 'Custom 2'
  end

  fit { subject }
end
