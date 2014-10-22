require 'spec_helper'

describe Guard::Gospel do
  let(:default_options) { Guard::Gospel::Options::DEFAULTS }
  let(:options) { {} }
  let(:plugin) { Guard::Gospel.new(options) }
  let(:runner) { Guard::Gospel::Runner }

  before {
    allow(Guard::UI).to receive(:info)
    allow(Guard::Gospel::Runner).to receive(:new) {runner}
  }

  describe '.initialize' do

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
      expect(Guard::UI).to receive(:info)
      expect(runner).to receive(:run).once
      plugin.start
    end
  end

  describe '#run_all' do
    it 'runs all specs  via runner' do
      expect(runner).to receive(:run_all) {true}
      plugin.run_all
    end

    it 'throws task_has_failed if runner return false' do
      expect(runner).to receive(:run_all) {false}
      expect(plugin).to receive(:throw).with(:task_has_failed)
      plugin.run_all
    end
  end

  describe '#reload' do
    it 'reloads via runner' do
      expect(runner).to receive(:reload)
      plugin.reload
    end
  end
end