require 'spec_helper'

describe Guard::GoSpel::Runner do
  let(:default_options) { Guard::GoSpel::Options::DEFAULTS }
  let(:sut){ Guard::GoSpel::Runner.new(default_options) }
  describe '.run' do
    let(:proc){ ChildProcess.build(default_options[:cmd], 'test') }
    context 'when get pid not zero' do
      it {expect(sut.pid).to_not eq(0)}
    end

    context 'with call childprocess.build'
    it do
      expect(ChildProcess).to receive(:build).with(default_options[:cmd], 'test').and_return(proc)
      expect(proc).to receive(:start).once
      expect(proc).to receive(:pid).once
      sut.run
    end
  end

  describe '.ps_go_pid' do
    context 'when get empty process list' do
      it { expect(sut.ps_go_pid).to eq([]) }
    end

    context 'when get process list' do
      it do
        sut.pid = 1
        expect(sut.ps_go_pid).to_not eq([])
      end
    end
  end
end