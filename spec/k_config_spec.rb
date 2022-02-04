# frozen_string_literal: true

RSpec.describe KConfig do
  it 'has a version number' do
    expect(KConfig::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise KConfig::Error, 'some message' }
      .to raise_error('some message')
  end
end
