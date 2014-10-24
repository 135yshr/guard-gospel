require 'spec_helper'

describe Guard::Gospel::Runner do
  let(:default_options) { Guard::Gospel::Options::DEFAULTS }
  let(:guard_runner){ Guard::Gospel::Runner.new(default_options) }

  describe '#run' do
    context 'when success command' do
      let(:proc){ ChildProcess.build(default_options[:cmd], 'test') }
      it 'return 0' do
        allow(proc).to receive(:exit_code) {0}
        expect(ChildProcess).to receive(:build).with(default_options[:cmd], 'test') { proc }
        expect(proc).to receive(:start).once
        expect(proc).to receive(:wait).once
        expect(::Guard::Notifier).to receive(:notify).with("Success", title: default_options[:title], image: :success, priority: -2)
        guard_runner.run
      end
    end

    context 'when fail command' do
      let(:proc){ ChildProcess.build(default_options[:cmd], 'test') }
      it "return 1" do
        allow(proc).to receive(:exit_code) {1}
        expect(ChildProcess).to receive(:build).with(default_options[:cmd], 'test') { proc }
        expect(proc).to receive(:start).once
        expect(proc).to receive(:wait).once
        expect(::Guard::Notifier).to receive(:notify).with("Fail", title: default_options[:title], image: :failed, priority: 2)
        guard_runner.run
      end
    end
  end

end
