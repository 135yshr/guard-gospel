require 'spec_helper'

describe Guard::GoSpel::Runner do
  let(:default_options) { Guard::GoSpel::Options::DEFAULTS }
  let(:guard_runner){ Guard::GoSpel::Runner.new(default_options) }
  describe '.run' do
    context 'when get pid not zero' do
      it do
        sut = Guard::GoSpel::Runner.new(default_options)
        expect(sut.pid).to eq(nil)
      end
    end

    context 'when call childprocess.build' do
      let(:proc){ ChildProcess.build(default_options[:cmd], 'test') }
      it do
        expect(ChildProcess).to receive(:build).with(default_options[:cmd], 'test').and_return(proc)
        expect(proc).to receive(:start).once
        expect(proc).to receive(:pid).once
        guard_runner.run
      end
    end
  end

  describe '.ps_go_pid' do
    context 'when get empty process list' do
      it { expect(guard_runner.ps_go_pid).to eq([]) }
    end

    context 'when get process list' do
      it do
        ptbl = Sys::ProcTable::ProcTableStruct.new(ppid: 1)
        allow(Sys::ProcTable::ps).to receive(:select).and_return([ptbl])
        guard_runner.pid = 1
        expect(guard_runner.ps_go_pid).to_not eq([])
      end
    end
  end
end