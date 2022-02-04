# frozen_string_literal: true

module Name1Extension
  attr_accessor :name1
end

module Name2Extension
  attr_accessor :name2
end

module ExtraExtension
  attr_accessor :first_name
  attr_accessor :last_name
end

module DebugMeExtension
  attr_accessor :custom1
  attr_accessor :custom2

  def debug_me_debug
    log.kv 'custom1', custom1
    log.kv 'custom2', custom2
  end
end

module CloneMeExtension
  attr_accessor :clone1
  attr_accessor :clone2

  def clone_me_initialize_copy(orig)
    @clone1 = "#{orig.clone1.clone}_copy"
    @clone2 = "#{orig.clone2.clone}_copy"
  end
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

  context 'when registering an extension module' do
    before { described_class.register(:extra, ExtraExtension) }

    let(:instance) { described_class.new }

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

      describe '#to_h' do
        subject { instance.to_h(symbolize_keys: true) }

        it { is_expected.to include(config_name: :test) }

        context 'with instance_variable' do
          before do
            instance.first_name = 'john'
            instance.last_name = 'doe'
          end

          it { is_expected.to include(config_name: :test, first_name: 'john', last_name: 'doe') }
        end
      end
    end
  end

  context 'when registering an extension module with debug method' do
    before { described_class.register(:debug_me, DebugMeExtension) }

    describe '#debug' do
      subject { instance.debug }

      let(:instance) { KConfig.configuration }

      before do
        instance.config_name = :debug
        instance.custom1 = 'Custom 1'
        instance.custom2 = 'Custom 2'
      end

      it { subject }
    end
  end

  context 'when registering an extension module with initialize_copy method' do
    before { described_class.register(:clone_me, CloneMeExtension) }

    describe '#clone' do
      subject { instance.clone }

      let(:instance) { KConfig.configuration }

      before do
        instance.config_name = :clone
        instance.clone1 = 'Clone1'
        instance.clone2 = 'Clone2'
      end

      it { is_expected.to have_attributes(clone1: 'Clone1_copy', clone2: 'Clone2_copy') }
    end
  end

  context 'class methods' do
    describe '#registered_keys' do
      subject { described_class.registered_keys }

      it { is_expected.not_to include(:name1, :name2) }

      context 'after registering a key' do
        before { described_class.register(:name1, Name1Extension) }

        it { is_expected.to include(:name1) }

        context 'after registering another key' do
          before { described_class.register(:name2, Name2Extension) }

          it { is_expected.to include(:name1, :name2) }
        end
      end
    end
  end
end
