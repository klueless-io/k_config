# frozen_string_literal: true

module ExtraAccessors
  attr_accessor :first_name
  attr_accessor :last_name
end

class CustomConfig
  attr_accessor :custom
end

RSpec.describe KConfig::Configuration do
  it { is_expected.to respond_to(:config_name) }

  context 'when overriding default configuration type' do
    around(:each) do |example|
      KConfig.default_configuration_type = CustomConfig
      example.run
      KConfig.default_configuration_type = KConfig::Configuration
    end

    subject { KConfig.reset(:new_configuration) }

    it { is_expected.to be_a(CustomConfig).and respond_to(:custom) }
  end

  context 'when extending with a module' do
    before { described_class.include(ExtraAccessors) }

    let(:instance) { described_class.new }

    context 'when extending configuration with extra accessors' do
      describe '#to_h' do
        subject { instance.to_h }

        it { is_expected.to eq({}) }

        context 'with instance_variable' do
          before do
            instance.first_name = 'john'
            instance.last_name = 'doe'
          end

          it { is_expected.to eq({ 'first_name' => 'john', 'last_name' => 'doe' }) }
        end
      end
    end

    context 'when accessing extended configuration' do
      subject { instance }

      let(:instance) { KConfig.reset(:test) }

      context 'accessors defined' do
        it { is_expected.to respond_to(:first_name).and respond_to(:last_name) }
        it { is_expected.not_to respond_to(:xmen) }
      end

      context 'accessors set' do
        before do
          instance.first_name = 'john'
          instance.last_name = 'doe'
        end

        it { is_expected.to have_attributes(first_name: 'john', last_name: 'doe') }
      end
    end
  end
end
