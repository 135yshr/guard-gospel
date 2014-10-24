require 'spec_helper'

describe Guard::Gospel::Runner do
  let(:default_options) { Guard::Gospel::Options::DEFAULTS }
  let(:guard_runner){ Guard::Gospel::Runner.new(default_options) }

  describe '#run' do
    let(:proc){ ChildProcess.build(default_options[:cmd], 'test') }
    it 'call childprocess.build' do
      expect(ChildProcess).to receive(:build).with(default_options[:cmd], 'test').and_return(proc)
      expect(proc).to receive(:start).once
      expect(proc).to receive(:pid).once
      guard_runner.run
    end
  end

  describe '#ps_go_pid' do
    context 'when get empty process list' do
      it { expect(guard_runner.ps_go_pid).to eq([]) }
    end

    context 'when get process list' do
      it do
        allow(Sys::ProcTable::ps).to receive(:select) {[Sys::ProcTable::ProcTableStruct.new(ppid: 1)]}
        guard_runner.pid = 1
        expect(guard_runner.ps_go_pid).to_not eq([])
      end
    end
  end
end
