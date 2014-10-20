require 'spec_helper'

describe Guard::GoSpel::Runner do
  let(:default_options) { Guard::GoSpel::Options::DEFAULTS }
  describe '.run' do
    let(:sut){ Guard::GoSpel::Runner.new(default_options) }
    let(:proc){ ChildProcess.build(default_options[:cmd], 'test') }
    it 'pid is not zero' do
      expect(sut.pid).to_not eq(0)
    end

    it 'call childprocess.build' do
      expect(ChildProcess).to receive(:build).with(default_options[:cmd], 'test').and_return(proc)
      expect(proc).to receive(:start).once
      expect(proc).to receive(:pid).once
      sut.run
    end
  end
end