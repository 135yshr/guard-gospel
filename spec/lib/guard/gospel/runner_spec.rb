require 'spec_helper'

describe Guard::GoSpel::Runner do
  let(:default_options) { Guard::GoSpel::Options::DEFAULTS }
  let(:sut){ Guard::GoSpel::Runner.new(default_options) }
  describe '.run' do
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

  describe '.ps_go_pid' do
    it 'count process table' do
      expect(sut.ps_go_pid).to_not eq([])
    end
    it 'count process table2' do
      expect(Sys::ProcTable.ps).to receive(select)
      sut.ps_go_pid
    end
  end
end