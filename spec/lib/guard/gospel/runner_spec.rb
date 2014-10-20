require 'spec_helper'

describe Guard::GoSpel::Runner do
  let(:default_options) { Guard::GoSpel::Options::DEFAULTS }
  describe '.run' do
    let(:sut){Guard::GoSpel::Runner.new(default_options)}
    # let(:proc){ChildProcess.build(default_options[:cmd], 'test')}
    it '.run' do
      expect(sut.pid).to_not eq(0)
    end
    it '.run child process' do
      expect(ChildProcess).to receive(:build).with(default_options[:cmd], 'test')
      sut.run
    end
  end
end