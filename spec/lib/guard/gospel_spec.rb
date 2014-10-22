require 'spec_helper'

describe Guard::Gospel do
  describe '.initialize' do
  	let(:default_options) { Guard::Gospel::Options::DEFAULTS }
  	let(:options) { {} }
    let(:plugin) { Guard::Gospel.new(options) }

    it 'instanciates with default and custom options' do
      guard_gospel = Guard::Gospel.new(foo: :bar)
      expect(guard_gospel.options).to eq(default_options.merge(foo: :bar))
    end
    it 'instanciates Runner with all default and custom options' do
      expect(Guard::Gospel::Runner).to receive(:new).with(default_options.merge(foo: :bar))
      Guard::Gospel.new(foo: :bar)
    end
    it 'warns deprecated options' do
      expect(Guard::Gospel::Deprecator).to receive(:warns_about_deprecated_options).with(default_options.merge(foo: :bar))
      Guard::Gospel.new(foo: :bar)
    end
  end

  describe '#start' do
    it 'calls runner#run' do
    end
  end
end