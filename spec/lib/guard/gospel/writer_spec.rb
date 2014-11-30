require 'spec_helper'

describe Guard::Gospel::Writer do
  let(:default_options) { Guard::Gospel::Options::DEFAULTS }
  let(:guard_writer){ Guard::Gospel::Writer.new(default_options) }
  let(:strio) { StringIO.new }

  describe '#write' do
    context 'when success command' do
      it 'write stdout' do
        expect(STDOUT).to receive(:write).with('aaa')
        guard_writer.write "aaa"
      end
      it 'write stringio' do
        allow(StringIO).to receive(:new)
        expect(strio).to receive(:write).with('aaa')
        guard_writer.write "aaa"
      end
    end
  end

  describe '#to_io' do
    context 'when success command' do
      it do
        expect(guard_writer.to_io).not_to eq nil
      end
    end
  end

  describe '#string' do
    context 'when success command' do
      it do
        expect(guard_writer.string).to eq ''
      end
    end
  end
end
