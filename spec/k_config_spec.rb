# frozen_string_literal: true

RSpec.describe KConfig do
  it 'has a version number' do
    expect(KConfig::VERSION).not_to be nil
  end

  describe 'configuration helpers' do
    let(:instance) { described_class }

    describe '#default_configuration_type' do
      subject { instance.default_configuration_type }

      before { instance.default_configuration_type = nil }

      it { is_expected.to eq(KConfig::Configuration) }
    end

    describe '#configuration' do
      context 'when config_name is not passed' do
        subject { instance.configuration }

        it { is_expected.to have_attributes(config_name: :default) }
      end

      context 'when config_name is passed' do
        subject { instance.configuration(:test) }

        it { is_expected.to have_attributes(config_name: :test) }
      end
    end

    describe '#reset' do
      it { expect { instance.reset(:will_reset) }.to change { instance.configuration(:will_reset).object_id } }
      it { expect { instance.reset(:will_reset) }.not_to change { instance.configuration(:will_reset).config_name } }

      context 'when config_name is not passed' do
        subject { instance.reset }

        it { is_expected.to have_attributes(config_name: :default) }
      end

      context 'when config_name is passed' do
        subject { instance.reset(:test) }

        it { is_expected.to have_attributes(config_name: :test) }
      end
    end

    describe '#configure' do
      let(:current_config) { instance.configuration(:altered) }

      it do
        expect do
          instance.configure(:altered) do |config|
            config.config_name = :changed
          end
        end.to change { current_config.config_name }.from(:altered).to(:changed)
      end
    end
  end
end
